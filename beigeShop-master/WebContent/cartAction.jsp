<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="cart.CartDAO" %><%--
  Created by IntelliJ IDEA.
  User: admins
  Date: 2021-10-06
  Time: 오전 7:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%
//        System.out.println("request = " + request.getParameter("checkArr"));
        CartDAO cartDAO = new CartDAO();
//        System.out.println("asdsadsad = " + request.getParameterValues("checkArr"));
        String id = (String) session.getAttribute("userID");
        System.out.println("session.getAttribute(\"userID\") = " + session.getAttribute("userID"));
        String[] name = request.getParameterValues("checkArr");
        for (int i = 0; i < name.length; i++) {
            System.out.println("name[i] = " + name[i]);
            int sid = Integer.parseInt(name[i]);
            cartDAO.deleteCart(sid, id);

        }

//        System.out.println("request === " + request.getAttribute("check"));
//        List<String> arrayList = new ArrayList<>();
//        List<String> arrayList = request.getParameter("check");


    %>