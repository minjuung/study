<%--<%@page import="java.text.SimpleDateFormat"%>--%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%-- <%@page import="java.util.ArrayList"%>--%>
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
	BoardDAO boardDAO = BoardDAO.getInstance();
	ArrayList<BoardDTO> boards = null;
	boolean isCategory = (request.getParameter("b_category") != null);
	if (isCategory) {
		boards = boardDAO.getList(request.getParameter("b_category"));
	} else {
		boards = boardDAO.getList();
	}
	UserDAO userDAO = new UserDAO();
	boolean isAdmin = userDAO.isAdmin(userID);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
%>
			<script src="./board.js"></script>
			<h4>BOARDS</h4>
			<table class="table"> 
				<tr align="center">
					<td width="90px" height="30px">글번호</td>
					<td width="300px">제목</td>
					<td width="90px">작성자</td>
					<td width="90px">조회수</td>
					<td width="150px">작성일</td>
					<% if (!isCategory) { %>
					<td width="90px">비공개</td>
					<% } %>
				</tr>
			    <%
				for (int i = 0; i < boards.size(); i++) {
					BoardDTO board = boards.get(i);
					boolean isMine = false;
					boolean isRef = board.getB_ref() != board.getB_id();
					if (isRef && userID != null) {
						BoardDTO refBoard = boardDAO.getBoard(board.getB_ref(), false);
						if (refBoard != null) {
							isMine = refBoard.getM_id().equals(userID);
						}
					}
					boolean isNotice = (board.getB_category().equals("공지") && !isCategory);
					String strURL = "boardView.jsp?b_id=" + board.getB_id() + ( isCategory ? "&b_category=" + request.getParameter("b_category") : "" );
					if (isNotice) {
						out.print("<tr style=\"cursor:pointer;\" bgcolor='#f2dec2'"
								+ "onmouseover=\"this.style.backgroundColor='#edd5b4'\" onmouseout=\"this.style.backgroundColor='#f2dec2'\" align=\"center\""
								+ "onClick=\"location.href='" + strURL + "'\" >");
					} else if (isMine || board.getM_id().equals(userID)) {
						out.print("<tr style=\"cursor:pointer;\" bgcolor='#f2f2f2'"
								+ "onmouseover=\"this.style.backgroundColor='#e6e6e6'\" onmouseout=\"this.style.backgroundColor='#f2f2f2'\" align=\"center\""
								+ "onClick=\"location.href='" + strURL + "'\" >");
					} else {
						out.print("<tr style='cursor:pointer;' "
								+ "onmouseover=\"this.style.backgroundColor='#f2f2f2'\" onmouseout=\"this.style.backgroundColor='#ffffff'\" align=\"center\""
								+ "onClick=\"location.href='" + strURL + "'\" >");
					}
					out.print("<td>" + (isNotice ? board.getB_category() : board.getB_id()) + "</td>");
					out.print("<td align='left'>" + (isRef?"<img src='images/outline_subdirectory_arrow_right_black_24dp.png'>":"") +board.getB_title() + "</td>");
					out.print("<td>" + board.getM_id() + "</td>");
					out.print("<td>" + board.getB_view() + "</td>");
					out.print("<td>" + sdf.format(board.getB_date()) + "</td>");
					if (!isCategory) {
						if (board.getB_secret().equals("0")) {
							out.print("<td> </td>");
						} else {
							out.print("<td><img src='images/outline_lock_black_24dp.png'></td>");	
						}
					}
					out.print("</tr>");
				}
				%>
				<tr>
					<td colspan="6" align="right">
						<% if (!isCategory || isAdmin) { %>
						<input type="button"
							value="글쓰기" onClick="canWrite('<%= userID == null ? "" : userID %>')"
							style="cursor: pointer;"
							class="btn btn-secondary">
						<% } %>
					</td>
				</tr>
			</table>         
	        <jsp:include page="footer.jsp"/>
	    </div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
        crossorigin="anonymous"></script>
<script src="./js/sidebars.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
</body>
</html>