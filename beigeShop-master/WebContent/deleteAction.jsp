<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="user.UserDTO" scope="page"/>
<jsp:setProperty name="user" property="userPassword"/>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
	    userID = (String) session.getAttribute("userID");
	} else {
		%><script>
			alert("잘못된 접근입니다.");
			location.href = "main.jsp";
		</script><%
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, user.getUserPassword());
	if (result == 1) {
		Date nowTime = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        if (userDAO.isAdmin(userID)) {
        	%><script>
			alert("관리자 계정은 탈퇴할 수 없습니다.");
			history.back();
			</script><%
        } else if (userDAO.deleteUser(userID, sf.format(nowTime)) == 1) {
			%><script>
			alert("탈퇴 처리되었습니다.");
			location.href = "logoutAction.jsp";
			</script><%
		} else {
			%><script>
				alert("탈퇴 처리 오류입니다.");
				history.back();
			</script><%
		}
	} else if (result == 0) {
		%><script>
		alert("비밀번호가 틀렸습니다.");
		history.back();
		</script><%
	} else {
		%><script>
		alert("탈퇴 처리 오류입니다.");
		history.back();
		</script><%
	}
%>
