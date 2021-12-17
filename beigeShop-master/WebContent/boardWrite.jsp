<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
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
	int b_ref = 0;
	BoardDAO boardDAO = null;
	BoardDTO board = null;
	String b_title = "";
	if (request.getParameter("b_ref") != null) {
		b_ref = Integer.parseInt(request.getParameter("b_ref"));
		boardDAO = BoardDAO.getInstance();
		board = boardDAO.getBoard(b_ref, false);
		b_title = "[답글] " + board.getB_title();
	}
	UserDAO userDAO = new UserDAO();
%>
			<script src="./board.js"></script>
			<h4>WRITE</h4>
			<table class="table">
				<form method="post" action="boardWriteOK.jsp" name="boardForm">
				<thead>
					<tr height="30px">
						<td>제목</td>
						<td><input class="form-control" name="b_title" type="text" size="55" value="<%= b_title %>"></td>
					</tr>
				</thead>
				<tr>
					<td colspan="2"><textarea class="form-control" name="b_content" rows="10" cols="55"></textarea></td>
				</tr>
				<tr height="30">
					<td colspan="2" align="right">
						<input type="hidden" name="b_ref" value=<%= b_ref %>>
						<input type="hidden" name="m_id" value=<%= userID %>>
						<% if (!userDAO.isAdmin(userID) || b_ref != 0) { %>
							<label class="custom-control-label"><input class="custom-control-input" type="checkbox" name="b_secret" checked> 비공개</label>
						<% } %>
						<input class="btn btn-secondary" type="button" onClick="doWrite()" value="글쓰기">
						<input class="btn btn-secondary" type="reset" value="다시쓰기">
						<input class="btn btn-secondary" type="button"
							value="목록" onClick="location.href='boardList.jsp'"
							style="cursor: pointer;"
							class="btn btn-secondary">
					</td>
				</tr>
				</form>
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