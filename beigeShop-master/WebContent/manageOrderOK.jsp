<%@page import="order.OrderDAO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String userID = null;
if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
}

UserDAO userDAO = null;
boolean isAdmin = false;
String o_id = null;
long o_ship = 0;
if (userID == null || request.getParameter("o_id") == null|| request.getParameter("o_ship") == null) {
	%><script>
	alert("잘못된 접근입니다.");
	location.href = "main.jsp";
	</script><%	
} else {
	userDAO = new UserDAO();
	isAdmin = userDAO.isAdmin(userID);
	o_id = request.getParameter("o_id");
	o_ship = Long.parseLong(request.getParameter("o_ship"));
}

if (!isAdmin) {
	%><script>
		alert("잘못된 접근입니다.");
		location.href = "main.jsp";
	</script><%
} else {
	OrderDAO order = new OrderDAO();
	if (o_ship < 0) {
		%><script>
		alert("잘못된 입력입니다.");
		history.back();
		</script><%
	} else if (order.updateStatus(o_id, o_ship) == 1) {
		%><script>
		alert("발송 처리되었습니다.");
		location.href = "manageOrder.jsp?o_id=<%= o_id %>";
		</script><%
	} else {
		%><script>
		alert("발송 처리를 실패하였습니다.");
		history.back();
		</script><%
	}
}
%>