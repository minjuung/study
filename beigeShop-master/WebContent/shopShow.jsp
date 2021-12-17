<%@page import="java.text.DecimalFormat"%>
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
	if (pageNum == null) {
		pageNum = "1";
	}
	int sid = Integer.parseInt(request.getParameter("s_id"));

	ProductDAO db = ProductDAO.getInstance();
	ProductDTO product = db.getProduct(sid);
	
	int s_id = 0, s_price = 0, s_stock=0;
	String s_name="", s_size="", s_category="", s_image="",s_image2="";
	
	s_id=product.getS_id();
	s_category=product.getS_category();
	s_name=product.getS_name();
	s_size=product.getS_size();
	s_price=product.getS_price();
	s_stock=product.getS_stock();
	s_image=product.getS_image();
	s_image2=product.getS_image2();
	
	DecimalFormat format = new DecimalFormat(" ₩ ###,###,###");
	
	String category = request.getParameter("category");
%>     
	<script>
		function addCart() {
			<%
			if (userID == null) {
			%>
				alert("로그인 해주세요.");
				location.href="login.jsp";
				return;
			<%
			}
			%>
			if (<%=s_stock %> == 0) { 
				alert("재고가 없습니다 ㅠㅠ");
				return;
			}
			var amount = prompt("[재고: <%= s_stock %>]구매하실 수량을 입력해 주세요.");
			if (Number(amount) > 0) {
				if (Number(amount) > <%=s_stock %>) {
					alert("주문하신 수량이 재고량보다 많습니다.");
					return;
				}
				location.href= "cartAdd.jsp?s_id=<%=s_id%>&c_amount=" + Number(amount);
			} else {
				alert("잘못된 입력입니다.");
				return;
			}
		}
	</script>
		<h4>ITEM</h4>
		<table class="table" >
		
		<tr align="center">
			<td colspan="2" align="center">
				<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%= s_image %>" height="200" width="200">
			</td>
		</tr>
		<tr>
			<td width="100"> 상품번호</td>
			<td width="200"><%=s_id %> </td>
		</tr>
		<tr>
			<td width="100"> 제품군</td>
			<td width="200"><%=s_category %> </td>
		</tr>
		<tr>
			<td width="100"> 재고량</td>
			<td width="200"><%=s_stock %> </td>
		</tr>
		<tr>
			<td width="100"> 상품명</td>
			<td width="200"><%=s_name %> </td>
		</tr>
		<tr>
			<td width="100"> 제품가격</td>
			<td width="200"><%= format.format(s_price) %> </td>
		</tr>
		<tr>
			<td colspan="4" align="right">
				<input type="button" class="btn btn-secondary" value="상품구매" onclick="addCart()">
				<input type="button" class="btn btn-secondary" value="상품목록" onclick="location.href='shopList.jsp?<%= category != null ? "category=" + category + "&" : "" %>pageNum=<%=pageNum%>'"> 
			</td>
		</tr>
		<% if (s_image2 != null) { %>
		<tr>
			<td colspan="2" align="center">
				<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=s_image2%>">
			</td>
		</tr>
		<tr>
			<td colspan="4" align="right">
				<input type="button" class="btn btn-secondary" value="상품구매" onclick="addCart()">
				<input type="button" class="btn btn-secondary" value="상품목록" onclick="location.href='shopList.jsp?<%= category != null ? "category=" + category + "&" : "" %>pageNum=<%=pageNum%>'"> 
			</td>
		</tr>
		<% } %>
			<!-- <tr height="30" align="center">
				<td width="100"> 상품번호</td>
				<td width="200"><%=s_id %> </td>
			</tr>
			<tr height="30" align="center">
				<td width="100"> 제품군</td>
				<td width="200"> <%=s_category %></td>
				<td width="100"> 재고량</td>
				<td width="200"> <%=s_stock %></td>
			</tr>
			<tr height="30" align="center">
				<td width="110">파&nbsp;&nbsp;일</td>
					<td><img src="C:/Users/USER/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/wpqkf/upload/<%=s_image%>" height="500" width="500"></td>
					<td><img src="C:/Users/USER/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/wpqkf/upload/<%=s_image2%>" height="3000" width="700"></td>
				
			</tr>
			<tr height="30">
				<td width="100" align="center"> 상품명</td>
				<td colspan="3" width="200"> <%=s_name %></td>
			</tr>
			<tr height="30">
				<td width="100" align="center"> 제품 가격</td>
				<td colspan="3" width="200"> 
					<%=s_price%>
				</td>
			</tr>
			<tr height="30">
				<td colspan="4" align="right">
					<input type="button" value="상품구매" onclick="location.href='edit.jsp?s_id=<%=s_id%>&pageNum=<%=pageNum%>'">
					<input type="button" value="장바구니" onclick="location.href='delete.jsp?s_id=<%=s_id %>&pageNum=<%=pageNum%>'"> 
					<input type="button" value="상품목록" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'"> 
				</td>
			</tr> -->
		</table>
        </div>
        <jsp:include page="footer.jsp"/>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
        crossorigin="anonymous"></script>
<script src="./js/sidebars.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
</body>
</html>