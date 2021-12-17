<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int b_id = Integer.parseInt(request.getParameter("b_id"));
	BoardDAO boardDAO = BoardDAO.getInstance();
	if(boardDAO.deleteBoard(b_id) == 1){
		response.sendRedirect("boardList.jsp");
	} else {
%>
	<script>
		alert("글 삭제 실패");
		history.go(-1);
	</script>
<%
	}
%>