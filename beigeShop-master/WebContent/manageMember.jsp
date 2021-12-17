<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.UserDTO"%>
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
        <h4>Members</h4>
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
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>주소</th>
					<th>번호</th>
					<th>이메일</th>
					<th>주문량</th>
					<th>가입일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
			<%
				ArrayList<UserDTO> userDTOs = userDAO.listUsers();
				// SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
				// System.out.println("@@@@@@@@@@@@@@@@ userDTOs.size() = " + userDTOs.size());
				for (UserDTO userDTO : userDTOs) {
					String uID = userDTO.getUserId();
					if (userDAO.isAdmin(uID)) {
			%>
				<tr style="font-size: small;" class="table-info">
			<%			
					} else if (userDAO.defineUserId(uID).getUserGrade() == -1) {
			%>
				<tr style="font-size: small;" class="table-light">
			<%			
					} else {
			%>
				<tr style="font-size: small;">
			<%
					}
			%>
					<td><%= uID %></td>
					<td><%= userDTO.getUserName() %></td>
					<td><%= userDTO.getUserAddress().replace("/", ", ") %></td>
					<td><%= userDTO.getMobileNumber() %></td>
					<td><%= userDTO.getUserEmail() %></td>
					<td><%= userDTO.getUserPurchase() %></td>
					<td><%= userDTO.getUserSingUp() %></td>
					<td><input type="button" class="btn btn-dark btn-sm" onClick="delete_check_admin('<%= userDTO.getUserId() %>')" value="탈퇴"></td>
				</tr>	
			<%					
				}
		}
			%>
			</tbody>
		</table>

		</div>
        <jsp:include page="footer.jsp"/>
    </div>
</div>
<script type="text/javascript" src="script.js" charset="utf-8"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
        crossorigin="anonymous"></script>
<script src="./js/sidebars.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
</body>
</html>