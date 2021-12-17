<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<!--<%@page import="java.sql.Timestamp"%>-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   int b_id = Integer.parseInt(request.getParameter("b_id"));
   
   BoardDAO boardDAO = BoardDAO.getInstance();
   BoardDTO board = new BoardDTO();
   
   board.setB_id(b_id);
   board.setB_title(request.getParameter("b_title"));
   board.setB_content(request.getParameter("b_content"));
   if(request.getParameter("b_secret") == null){
      //공개글
      board.setB_secret("0");
   }else{
      //비공개글
      board.setB_secret("1");      
   }
   

   if(boardDAO.editBoard(board) == 1){
      response.sendRedirect("boardView.jsp?b_id=" + b_id);
   }else{
%>
      <script>
         alert("글 수정 실패");
         history.go(-1);
      </script>
<%
   }
%>