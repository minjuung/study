<%@page import="user.UserDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%--<%@page import="java.sql.Timestamp"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	BoardDAO boardDAO = BoardDAO.getInstance();
	BoardDTO board = new BoardDTO();
	UserDAO userDAO = new UserDAO();
	String userID = (String) session.getAttribute("userID");
	boolean isAdmin = userDAO.isAdmin(userID);
	
	int b_ref = Integer.parseInt(request.getParameter("b_ref"));
	board.setB_ref(b_ref);
	board.setB_title(request.getParameter("b_title"));
	board.setB_content(request.getParameter("b_content"));
	board.setB_view(0);
	board.setM_id(userID);
	board.setB_category((isAdmin && b_ref == 0) ? "공지" : "문의");
	board.setB_date(new Timestamp(System.currentTimeMillis()));
	if (request.getParameter("b_secret") == null || (isAdmin && b_ref == 0)) {
		//공개글
		board.setB_secret("0");
	} else {
		//비공개글
		board.setB_secret("1");
	}
	
	if (boardDAO.writeBoard(board) == 1) {
		response.sendRedirect("boardList.jsp");
	} else {
%>
<script>
	alert("글 작성 실패");
	history.go(-1);
</script>
<%
	}
%>