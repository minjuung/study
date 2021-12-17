<%@ page import="user.RequestMessage" %>
<%@ page import="user.CertifiedPhoneNumber" %>
<%@ page import="java.util.Random" %>
<%@ page import="user.UserDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String number1 = request.getParameter("phoneNumber");
    Random rand  = new Random();
        String cerNum="";

        for(int i=0; i<4; i++) {
            String ran = Integer.toString(rand.nextInt(10));
            cerNum+=ran;
        }

        RequestMessage requestMessage = new RequestMessage();
        requestMessage.sendMessage(number1, cerNum);

    %>

<%
    //인증을 위해 생성된 난수 JSP 로 값전달
    out.print(cerNum);
%>
