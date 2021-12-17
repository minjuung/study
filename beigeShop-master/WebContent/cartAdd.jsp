<%@page import="cart.CartDAO"%>
<%@page import="cart.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	int s_id = 0;
	if (request.getParameter("s_id") != null) {
		s_id = Integer.parseInt(request.getParameter("s_id"));
	}
	int c_amount = 0;
	if (request.getParameter("c_amount") != null) {
		c_amount = Integer.parseInt(request.getParameter("c_amount"));
	}
	String userID = (String) session.getAttribute("userID");
	if(s_id == 0 || c_amount == 0 || userID == null) {
		%><script>
			alert("잘못된 접근입니다.");
			location.href = "shopList.jsp";
		</script><%
	} else {
		CartDTO cartDTO = new CartDTO(userID, s_id, c_amount);
		CartDAO cartDAO = new CartDAO();
		if (cartDAO.isCart(userID, s_id)) {
			%><script>
				alert("이미 장바구니에 추가한 상품입니다.");
				location.href="cart.jsp";
			</script><%
		} else if (cartDAO.addCart(cartDTO) == 1) {
			%><script>
				if (confirm("장바구니로 이동하시겠습니까?") == true) {
					location.href="cart.jsp";	
				} else {
					history.go(-1);
				}
			</script><%
		} else {
			%><script>
			alert("장바구니 추가가 실패하였습니다.");
			history.go(-1);
			</script><%
		}
	}
%>
