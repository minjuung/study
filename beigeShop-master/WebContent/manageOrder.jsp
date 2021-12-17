<%@page import="user.UserDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.io.File"%>
<%@page import="product.ProductDTO"%>
<%@page import="product.ProductDAO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="order.OrderDTO"%>
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
<%
	UserDAO userDAO = null;
	boolean isAdmin = false;
	String o_id = null;
	if (userID == null || request.getParameter("o_id") == null) {
		%><script>
		alert("잘못된 접근입니다.");
		location.href = "main.jsp";
		</script><%	
	} else {
		userDAO = new UserDAO();
		isAdmin = userDAO.isAdmin(userID);
		o_id = request.getParameter("o_id");
	}
	
	if (!isAdmin) {
		%><script>
			alert("잘못된 접근입니다.");
			location.href = "main.jsp";
		</script><%
	} else {
		OrderDAO orderDAO = new OrderDAO();
		OrderDTO orderDTO = orderDAO.orderDetailView(o_id);
		
		DecimalFormat dc = new DecimalFormat("###,###,###");
		
%>
   			<h4>Order: <%= o_id %></h4>
   			<table class="table">
   				<tr align="center">
   					<th>상품ID</th>
   					<th>이미지</th>
   					<th>상품명</th>
   					<th>사이즈</th>
   					<th>수량</th>
   				</tr>
   				<%
   					JSONParser parser = new JSONParser();
   			       	JSONArray items = (JSONArray) parser.parse(orderDTO.getO_ids());
   			       	JSONArray itemQTY = (JSONArray) parser.parse(orderDTO.getO_qtys());
   			       	for (int i = 0 ; i < items.size(); i ++) {
   			       		ProductDAO productDAO = ProductDAO.getInstance();
   			       		ProductDTO productDTO = productDAO.getProduct(Integer.parseInt(items.get(i).toString()));
   			           	%>
				<tr align="center">
					<td><%= productDTO.getS_id() %></td>
					<td><img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%= productDTO.getS_image() %>" height="150" width="150"></td>
					<td><%= productDTO.getS_name() %></td>
					<td><%= productDTO.getS_size() %></td>
					<td><%= itemQTY.get(i) %></td>
				</tr>
	            <%
   			       	}
  				%>
  				<tr><td colspan="5"></td></tr>
  				<tr align="center">
  					<th>결제 금액</th>
  					<td>₩ <%= dc.format(orderDTO.getPrice()) %></td>
  					<th>결제 일자</th>
  					<td colspan="2"><%= orderDTO.getOrderDate() %></td>
  				</tr>
  				<tr><td colspan="5"></td></tr>
 				<%
 					UserDTO orderUser = userDAO.view(orderDTO.getM_id());
 				%>
  				<tr align="center">
  					<th>주문자명</th>
  					<td colspan="4"><%= orderUser.getUserName() %></td>
  				</tr>
  				<tr align="center">
  					<th>연락처</th>
  					<td colspan="4"><%= orderUser.getMobileNumber() %></td>
  				</tr>
  				<tr align="center">
  					<th>주소</th>
  					<td colspan="4"><%= orderUser.getUserAddress().replace("/", " ") %></td>
  				</tr>
  				<tr align="center">
  					<th>배송 요청 사항</th>
  					<%
  						String orderRequest = "-";
  						if (orderDTO.getRequest() != null) {
  							orderRequest = orderDTO.getRequest();
  						}
  					%>
  					<td colspan="4"><%= orderRequest %></td>
  				</tr>
				<% if (orderDTO.getTracking() == -1) { %>
				<tr align="center" bgcolor="#eee">
					<form action="manageOrderOK.jsp" method="post">
						<th>배송 정보</th>
						<td align="right">CJ대한통운 운송장 번호</td>
						<td colspan="2" align="left"><input type="text" name="o_ship" class="form-control w-50"></td>
						<td align="left">
							<input type="hidden" name="o_id" value="<%= o_id %>">
							<input type="submit" value="발송 처리" class="btn btn-dark btn-sm">
						</td>
					</form>
				<% } else { %>
				<tr align="center">
					<th>배송 정보</th>
 					<td><%= orderDTO.getType() %></td>
 					<td colspan="3"><%= orderDTO.getTracking() %></td>
				<% } %>
  				</tr>
  				<tr align="right">
  					<td colspan="5"><input type="button" value="상품 관리 목록" onClick="location.href='manageOrders.jsp'" class="btn btn-dark btn-sm"></td>
 				</tr>
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