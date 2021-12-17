<%@ page import="user.UserDAO" %><%--
  Created by IntelliJ IDEA.
  User: admins
  Date: 2021-11-01
  Time: 오후 2:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String getUserId = request.getParameter("userId");

    int numberOfDefine = 0;
    String sqlUserId;
    UserDAO userDAO = new UserDAO();

    try {
        sqlUserId = userDAO.defineUserId(getUserId).getUserId();

        if (sqlUserId.equals(getUserId)){
            numberOfDefine = 1;
        }


    } catch (NullPointerException e){
        numberOfDefine = -1;
    }

    System.out.println("request = " + request.getParameter("userId"));
    out.print(numberOfDefine);
%>
