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
            <h4>Login</h4>

            <div class="container" id="modify">
                <div class="input-form-backgroud row">
                    <div class="input-form col-md-12 mx-auto">
                        <h4 class="mb-3"></h4>
                        <form class="validation-form" novalidate action="loginAction.jsp" method="post">
                            <div class="row">
                                <div class="col-md-5 ">
                                    <%--                                    <label for="userId">아이디</label>--%>
                                    <input type="text" class="form-control" name="userId" id="userId" placeholder="ID"
                                           value="" required>

                                    <%--                                    <label for="userPassword">비밀번호</label>--%>
                                    <input type="password" class="form-control" name="userPassword" id="userPassword"
                                           placeholder="PASSWORD" value="" required>
                                    <hr class="mb-4">
                                    <button class="btn btn-primary btn-sm btn-block " id="loginButton" type="submit"
                                            formaction="loginAction.jsp">LOGIN
                                    </button>
                                        <button class="btn btn-primary btn-sm btn-block " id="loginButton" type="submit"
                                                formaction="register.jsp">REGISTER
                                        </button>
                                </div>
                                <%--                                <div class="col-md-6 mb-3">--%>

                                <%--                                </div>--%>
                                <%--                            <hr class="mb-4">--%>
                                <div class="mb-4"></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
        crossorigin="anonymous"></script>

<%--도로명주소--%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="./js/sidebars.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>

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
