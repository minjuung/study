<%@page import="java.text.DecimalFormat"%>
<%@page import="product.ProductDTO"%>
<%@page import="product.ProductDAO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="order.OrderDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="order.OrderDAO"%>
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
   			<h4>Orders</h4>
<%
	UserDAO userDAO = null;
	boolean isAdmin = false;
	if (userID == null) {
		%><script>
		alert("잘못된 접근입니다.");
		location.href = "main.jsp";
		</script><%	
	} else {
		userDAO = new UserDAO();
		isAdmin = userDAO.isAdmin(userID);
	}
	
	if (!isAdmin) {
		%><script>
			alert("잘못된 접근입니다.");
			location.href = "main.jsp";
		</script><%
	} else {
%>
   			<table class="table">
   				<thead>
   					<tr align="center">
   						<th>주문번호</th>
   						<th>주문일자</th>
   						<th>아이디</th>
   						<th>주문상품</th>
   						<th>가격</th>
   						<th>상태</th>
   						<th>관리</th>
   					</tr>
   				</thead>
   				<tbody>
				<%
				OrderDAO orderDAO = new OrderDAO();
				ArrayList<OrderDTO> orders = orderDAO.viewOrders();
				DecimalFormat dc = new DecimalFormat("###,###,###");
				
				if (orders.size() == 0) {
					%>
					<tr align="center">
						<td colspan="7">주문 내역이 없습니다. ㅠㅠ</td>
					</tr>
					<%
				} else {
					for (OrderDTO order : orders) {
						boolean needCheck = order.getStatus().equals("결제 완료");
						
						if (needCheck) {
					%><tr align="center" bgcolor="#ffcccc"><%
						} else {
					%><tr align="center"><%		
						}
					%>
   						<td><%= order.getOrderNumber() %></td>
   						<td><%= order.getOrderDate() %></td>
   						<td><%= order.getM_id() %></td>
   						<td>
   						<%
   						JSONParser parser = new JSONParser();
   	                	JSONArray items = (JSONArray) parser.parse(order.getO_ids());
   	                	JSONArray itemQTY = (JSONArray) parser.parse(order.getO_qtys());
   	                	for (int i = 0 ; i < items.size(); i ++) {
   	                		ProductDAO productDAO = ProductDAO.getInstance();
   	                		ProductDTO productDTO = productDAO.getProduct(Integer.parseInt(items.get(i).toString()));
   		                	%>
   		                    <a href="shopShow.jsp?s_id=<%= productDTO.getS_id() %>"><%= productDTO.getS_name() %></a>: <%= itemQTY.get(i) %>개
   		                    <%
   		                    if (i < items.size() - 1) {
   		                    	out.print("<br>");
   		                    }
   	                	}
   						%>
   						</td>
   						<td><%= dc.format(order.getPrice()) %></td>
   						<td><%= order.getStatus() %></td>
   						<td><input type="button" class="btn btn-dark btn-sm" onClick="location.href='manageOrder.jsp?o_id=<%= order.getOrderNumber()%>'" value="관리"></td>
   					</tr>
   				<%
					}
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
        crossorigin="anonymous"></script>
<script src="./js/sidebars.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
</body>
</html>
