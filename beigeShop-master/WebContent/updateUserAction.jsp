<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: admins
  Date: 2021-10-06
  Time: 오전 7:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="user.UserDTO"/>
<%--<jsp:setProperty name="user" property="userId"/>--%>
<%--<jsp:setProperty name="user" property="userPassword"/>--%>
<%--<jsp:setProperty name="user" property="userEmail"/>--%>
<%--<jsp:setProperty name="user" property="userName"/>--%>
<%--<jsp:setProperty name="user" property="mobileNumber"/>--%>
<%--<jsp:setProperty name="user" property="phoneNumber"/>--%>
<%--<jsp:setProperty name="user" property="userAddress"/>--%>
<%--<jsp:setProperty name="user" property="userPasswordCheck"/>--%>

<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userAddress"/>
<jsp:setProperty name="user" property="mobileNumber"/>
<jsp:setProperty name="user" property="phoneNumber"/>
<jsp:setProperty name="user" property="userEmail"/>
<jsp:setProperty name="user" property="userId"/>
<%--<jsp:setProperty name="user" property="userSingUp"/>--%>
<%--<jsp:setProperty name="user" property="userGrade"/>--%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
    <title>Title</title>
</head>
<body>
<%
    UserDAO userDAO = new UserDAO();
    int result = userDAO.updateMember(user);
    if (result == 1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    } else{
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('실패했습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    String name = request.getParameter("userName");
%>
</body>
</html>