<%--
  Created by IntelliJ IDEA.
  User: admins
  Date: 2021-10-07
  Time: 오전 7:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>BEIGE</title>
</head>
<body>
  <%
  	session.setAttribute("userID", "");
    session.invalidate();
  %>
  <script>
    location.href = 'main.jsp';
  </script>
</body>
</html>
