<%--<%@page import="java.text.SimpleDateFormat"%> --%>
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
	UserDAO userDAO = new UserDAO();
	BoardDTO board = null;
	boolean isAdmin = userDAO.isAdmin(userID);
	boolean isMe = false;
	boolean isRef = false;
	boolean isMine = false;
	boolean isCategory = false;
	
	int b_id = 0;
	if (request.getParameter("b_id") == null || request.getParameter("b_id").length() == 0) {
		%><script>
			alert("잘못된 접근입니다.");
			location.href = "boardList.jsp";
		</script><%
	} else {
		b_id = Integer.parseInt(request.getParameter("b_id"));
		board = boardDAO.getBoard(b_id, true);
		isMe = board.getM_id().equals(userID);
		isRef = (board.getB_ref() != board.getB_id());
	}
	
	if (request.getParameter("b_category") != null) {
		isCategory = true;
	}
	
	if (board == null) {
		%><script>
			alert("잘못된 접근입니다.");
			location.href = "boardList.jsp";
		</script><%
	} else if (!board.getB_secret().equals("0")) {
		if (isRef) {
			BoardDTO refBoard = boardDAO.getBoard(board.getB_ref(), false);
			isMine = refBoard.getM_id().equals(userID);
		}
		if (!isMe && !isAdmin && !isMine) {
			%><script>
				alert("작성자만 볼 수 있는 비공개 글입니다.");
				location.href = "boardList.jsp";
			</script><%
		}
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
%>
<script>
	function deleteOK() {
		if (<%= !isMe && !isAdmin %>) {
			alert("작성자만 삭제가 가능합니다.");
			return;
		} else if (confirm("정말 글을 삭제하시겠습니까?") == true) {
			location.href = "boardDelete.jsp?b_id=" + <%= b_id %>;
		}
	}
</script>  
			<h4>BOARD</h4>
	      	<% if (board != null) { %>
			<table class="table"> 
				<thead>
					<tr>
						<td width="90px" height="30px"><%= board.getB_category()%></td>
						<td width="90px">조회수: <%= board.getB_view()%></td>
						<td width="180px"><%= sdf.format(board.getB_date()) %></td>
						<td width="100px">아이디: <%= board.getM_id()%></td>
					</tr>
					<tr>
						<td width="90px" height="30px">No.<%= board.getB_id()%></td>                  
						<td colspan="3">제목: <%= board.getB_title()%></td>
					</tr>
				</thead>
				<tr>
					<td colspan="4" height="300px"><%= board.getB_content()%></td>
				</tr>
				<tr height="30">
					<td colspan="4" align="right">
						<% if (isAdmin && !isRef) { %>
							<input type="button" class="btn btn-secondary" value="답글" onClick="location.href='boardWrite.jsp?b_ref=<%= b_id %>'" style="cursor:pointer;">
						<% } %>
						<% if (isMe || isAdmin) { %>
							<input type="button" class="btn btn-secondary" value="수정" onClick="location.href='boardEdit.jsp?b_id=<%= b_id %>'" style="cursor:pointer;">
							<input type="button" class="btn btn-secondary" value="삭제" onClick="deleteOK()" style="cursor:pointer;">
						<% } %>
						<input type="button" class="btn btn-secondary" value="목록" onClick="location.href='boardList.jsp<%= isCategory?"?b_category="+request.getParameter("b_category"):"" %>'" style="cursor:pointer;">
					</td>
				</tr>
			</table>   
			<% } %>      
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