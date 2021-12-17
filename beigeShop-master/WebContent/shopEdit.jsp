<%@page import="java.io.File"%>
<%@page import="product.ProductDTO"%>
<%@page import="product.ProductDAO"%>
<%@ page import="user.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Beige</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/navbar-static/">


    <!-- Bootstrap core CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">


    <%--    font    --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Anton&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Bree+Serif&family=Sunflower:wght@300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="styles.css"/>
    <link href="sidebars.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/airbnb.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <meta name="theme-color" content="#7952b3">


    <style>

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

    </style>


</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
%>

<%--     NAVI 구역     --%>
<jsp:include page="navi.jsp"/>

<div class="container-fluid">
    <div class="row">

        <%--        SIDEBAR 구역       --%>
        <div class="col-md-2">
            <jsp:include page="sidebar.jsp"/>
        </div>

        <%--        MAIN 구역         --%>
        <div class="col-md-8" id="title">
    <%
    	String pageNum = request.getParameter("pageNum");
       	int s_id=0;
       	String s_name = "";
       	if(request.getParameter("s_id") != null){
   	    	s_id = Integer.parseInt(request.getParameter("s_id"));
       	}
        	
       	ProductDAO db = ProductDAO.getInstance();
       	ProductDTO product = db.getProduct(s_id);
       	
       	UserDAO userDAO = new UserDAO();
       	boolean isAdmin = userDAO.isAdmin(userID);
       	
       	if (!isAdmin || s_id == 0 || product == null) {
    		%><script>
    			alert("잘못된 접근입니다.");
    			location.href = "main.jsp";
    		</script><%
    	}
    %>
	<script type="text/javascript" src="shop.js" charset="utf-8"></script>
	<h4>EDIT ITEM</h4>
		<form name="shopEditForm" method="post" action="shopEdit_ok.jsp" enctype="multipart/form-data">
			<input type="hidden" name="s_id" value="<%= s_id %>">
			
			<table class="table">
			<tr>
				<th width="30%">상품명</th>
				<td>
					<input type="text" name="s_name" size="30" value="<%= product.getS_name() %>">
				</td>
			</tr>
			<tr>
				<th width="30%">사이즈</th>
				<td>
					<select id="s_size" name="s_size" size="1">
						<option value="s">S
						<option value="m">M
						<option value="l">L
						<option value="free">FREE
					</select>
				</td>
			</tr>
			<tr>
				<th width="30%">상품분류</th>
				<td>
					<select id="s_category" name="s_category" size="1">
						<option value="zipuphoodie">ZIP UP HOODIE
						<option value="coat">COAT
						<option value="jacket">JACKET
						<option value="shortpants">SHORT PANTS
						<option value="denimpants">DENIM PANTS
						<option value="joggerpants">JOGGER PANTS
						<option value="slacks">SLACKS
						<option value="sandal">SANDAL
						<option value="slipper">SLIPPER
						<option value="boots">BOOTS
						<option value="loafers">LOAFERS
					</select>
				</td>
			</tr>
			<tr>
				<th width="30%">판매가</th>
				<td>
					<input type="number" name="s_price" size="10" value="<%= product.getS_price() %>">
				</td>
			</tr>
			<tr>
				<th width="30%">재고량</th>
				<td>
					<input type="number" name="s_stock" size="10" value="<%= product.getS_stock() %>">
				</td>
			</tr>
			
			<tr>
				<th width="30%">대표이미지</th>
				<td>
					<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%= product.getS_image() %>" height="100" width="100">
				</td> 
			</tr>
			<tr>
				<th width="30%">대표이미지 수정</th>
				<td>
					<input class="btn btn-light" type="file" name="s_image" size="30">
				</td> 
			</tr>
			<tr>	
				<th width="30%">상세이미지 수정</th>
				<td>
					<input class="btn btn-light" type="file" name="s_image2" size="30">
				</td> 
			</tr>	
			<tr height="50" align="center">
				<td colspan="4" >
					<input class="btn btn-secondary" type="button" value="상품수정" onclick="check_edit()">&nbsp;
					<input class="btn btn-secondary" type="reset" value="다시작성">&nbsp;
					<input class="btn btn-secondary" type="button" value="상품목록" onclick="location.href='manageShop.jsp'">&nbsp;
				</td>
			</tr>
			</table>
		</form>
        </div>
        <jsp:include page="footer.jsp"/>
    </div>
</div>
<script>
	$(function() {
		$('#s_size').val('<%= product.getS_size() %>').prop("selected",true);
		$('#s_category').val('<%= product.getS_category() %>').prop("selected",true);
	});
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
        crossorigin="anonymous"></script>
<script src="./js/sidebars.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
</body>
</html>