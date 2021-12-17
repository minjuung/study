<%--
  Created by IntelliJ IDEA.
  User: admins
  Date: 2021-11-03
  Time: 오후 9:35
  To change this template use File | Settings | File Templates.
--%>
<%@page import="user.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bree+Serif&family=Sunflower:wght@300&display=swap"
      rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Scheherazade+New&display=swap" rel="stylesheet">

<link rel="stylesheet" href="styles.css"/>


<style>
    .navbar .justify-content-md-center{
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        color:#d2b48c;
        font-weight: 100;
        font-family: 'Open Sans', sans-serif;
    }
    .navbar .justify-content-md-center:hover{
        color:#d2b48c;
    }

    .collapse .navbar-nav .nav-item .nav-link{
        font-size:15px;
        color:#d2b48c;
    }
    .collapse .navbar-nav .nav-item .nav-link:hover{
        color:#d2b48c;
    }

    .navbar .justify-content-md-center {
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
    }


    .list-unstyled .collapse .btn-toggle-nav .link-dark {
        background-color: transparent;
        border-color: gray;
    }
</style>

<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    UserDAO userDAO = new UserDAO();
	boolean isAdmin = userDAO.isAdmin(userID);
%>


<nav class="navbar navbar-expand-lg navbar-light bg-transparent" aria-label="Tenth navbar example">
    <div class="container-fluid">


        <a class="navbar-brand justify-content-md-center" href="main.jsp" id="navbarsExample08"><h2>Beige</h2></a>


        <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon "></span>
        </button>
        <div class="collapse navbar-collapse justify-content-md-end" id="navbarsExample09">
            <%
                if (userID == null) {
            %>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="listSet nav-link active" aria-current="page" href="login.jsp">LOGIN</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="login.jsp">ORDER</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="login.jsp">MY ACCOUNT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="login.jsp">CART</a>
                </li>
            </ul>
            <%
            } else {
            %>

            <ul class="navbar-nav">
           		<%-- <% if (isAdmin) { %>
           		<li class="nav-item">
           			<img src="images/outline_admin_panel_settings_black_24dp.png" class="w-75">
           		</li>
           		<% } %> --%>
            	<li class="nav-item">
                    <a class="nav-link active" aria-current="page"><%= userID %>님!</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="logoutAction.jsp">LOGOUT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="order.jsp">ORDER</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="account.jsp">MY ACCOUNT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="cart.jsp">CART</a>
                </li>
            </ul>
            <%
                }
            %>
        </div>
    </div>
</nav>
