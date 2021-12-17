<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	boolean isAdmin = userDAO.isAdmin(userID);
	if (!isAdmin) {
		%><script>
			alert("잘못된 접근입니다.");
			location.href = "main.jsp";
		</script><%
	} else {
		String deleteID = request.getParameter("delete_mID");
		Date nowTime = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        if (userDAO.isAdmin(deleteID)) {
        	%><script>
			alert("관리자 계정은 탈퇴할 수 없습니다.");
			history.back();
			</script><%
        } else if (userDAO.deleteUser(deleteID, sf.format(nowTime)) == 1) {
        	%><script>
			alert("탈퇴 처리되었습니다.");
			location.href = "manageMember.jsp";
			</script><%
        } else {
        	%><script>
			alert("탈퇴 처리 오류입니다.");
			history.back();
			</script><%
        }
	}
%>