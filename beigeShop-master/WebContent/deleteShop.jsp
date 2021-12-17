<%@page import="product.ProductDAO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userID = null;
	String productID = request.getParameter("s_id");
	if (session.getAttribute("userID") != null || productID != null) {
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
		ProductDAO productDAO = ProductDAO.getInstance();
		if (productDAO.deleteProduct(productID) == 1) {
			%><script>
			alert("해당 상품이 삭제되었습니다.");
			location.href = "manageShop.jsp";
			</script><%
		} else {
			%><script>
			alert("상품 삭제 오류입니다.");
			history.back();
			</script><%
		}
	}
%>