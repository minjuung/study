<%@page import="java.text.DecimalFormat"%>
<%@page import="java.io.File"%>
<%@page import="product.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
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
   			<h4>Manage Items</h4>
<%
	UserDAO userDAO = new UserDAO();
	boolean isAdmin = userDAO.isAdmin(userID);
	
	if (!isAdmin) {
	%><script>
		alert("잘못된 접근입니다.");
		location.href = "main.jsp";
	</script><%
	} else {
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null){
			pageNum ="1";
		}
		ProductDAO productDAO = ProductDAO.getInstance();
		ArrayList<ProductDTO> productList = productDAO.listProduct(pageNum, null);
		DecimalFormat format = new DecimalFormat("###,###,###");
%>
   			<table class="table">
   				<thead>
   					<tr align="center">
   						<th>No.</th>
   						<th>품목</th>
   						<th>이미지</th>
   						<th>상품</th>
   						<th>사이즈</th>
   						<th>가격</th>
   						<th>재고</th>
   						<th>관리</th>
   					</tr>
   				</thead>
   				<tbody>
   					<%
   					if (productList.size() == 0) {
   						%>
  						<tr align="center">
  							<td colspan="8">등록된 상품이 없습니다.</td>
  						</tr>
   						<%
   					} else {
   						for (ProductDTO product : productList) {
   							int s_id = product.getS_id();
   							if (product.getS_stock() == 0) {
						%>
							<tr style="font-size: small; cursor:pointer;"
								align="center"
								onClick="location.href='shopEdit.jsp?s_id=<%=s_id%>'"
		   						bgcolor="#ffeeee" 
								onmouseover="this.style.backgroundColor='#ffaaaa'"
								onmouseout="this.style.backgroundColor='#ffeeee'">
						<%   								
   							} else {
						%>
							<tr style="font-size: small; cursor:pointer;"
								align="center"
		   						bgcolor="#ffffff" 
		   						onClick="location.href='shopEdit.jsp?s_id=<%=s_id%>'"
								onmouseover="this.style.backgroundColor='#eeeeef'"
								onmouseout="this.style.backgroundColor='#ffffff'">
						<%
   							}
   						%>
   							<td><%= s_id %></td>
   							<td><%= product.getS_category() %></td>
   							<td><img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%= product.getS_image() %>" height="40" width="40"></td>
   							<td><%= product.getS_name() %></td>
   							<td><%= product.getS_size() %></td>
   							<td><%= format.format(product.getS_price()) %></td>
   							<td><%= product.getS_stock() %></td>
   							<td onclick="event.cancelBubble = true;"><input type="button" class="btn btn-dark btn-sm" onClick="delete_ok('<%= s_id %>')" value="삭제"></td>
   						</tr>
   						<%
   						}
   						%>
   						<tr align="center">
   							<td colspan="8">
   								<%= ProductDTO.pageNumber(4, "manageShop.jsp") %>
   							</td>
   						</tr>
   						<%
   					}
   					%>
   				</tbody>
   			</table>
<%
	}
%>
		</div>
        <jsp:include page="footer.jsp"/>
    </div>
</div>
<script type="text/javascript" src="shop.js" charset="utf-8"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
        crossorigin="anonymous"></script>
<script src="./js/sidebars.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
</body>