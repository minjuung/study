<%@page import="order.OrderDAO"%>
<%@page import="product.ProductDTO"%>
<%@page import="product.ProductDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="order.OrderDTO"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
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
	
	String orderID = null;
	if (request.getParameter("merchant_uid") != null) {
		orderID = request.getParameter("merchant_uid");
	} else {
		%><script>
			alert("잘못된 접근입니다.");
			location.href = "main.jsp";
		</script><%
	}
	
	JSONParser parser = new JSONParser();
	JSONArray items = (JSONArray) parser.parse(request.getParameter("items"));
	JSONArray itemQTY = (JSONArray) parser.parse(request.getParameter("itmQTY"));
	long item1 = Long.parseLong(items.get(0).toString());
	
	int price = Integer.parseInt(request.getParameter("paid_amount"));
    
    ProductDAO productDAO = ProductDAO.getInstance();
    ProductDTO productDTO = productDAO.getProduct((int) item1);
    
    System.out.println("orderID: " + orderID);
	
    OrderDTO orderDTO = new OrderDTO(
			//String orderNumber, 
			orderID,
			//Long productNumber, 
			item1,
			//int quantity, 
			Integer.parseInt(itemQTY.get(0).toString()),
			//int price, 
			price,
			//String orderDate, 
			"",
			//String status, 
			"결제 완료",
			//String request, 
			request.getParameter("orderMsg"),
			//Long tracking,
			(long) -1,
			//String type,
			"CJ대한통운",
			//String productName
			productDTO.getS_name()
	);
	/*
	private final String orderNumber;	// o_id
    private final Long productNumber;	// s_id
    private final int quantity;			// o_quantity
    private final int price;			// o_paid
    private final String orderDate;		// o_date
    private final String status;		// o_status
    private final String request;		// o_comment
    private final Long tracking;		// o_ship
    private final String productName;	// s_name
    private String type;				// o_type
    private String o_ids;
    private String o_qtys;
    */
    
    orderDTO.setO_iamport(request.getParameter("imp_uid"));
    orderDTO.setO_card(request.getParameter("apply_num"));
    
   	orderDTO.setO_ids(request.getParameter("items"));
   	orderDTO.setO_qtys(request.getParameter("itmQTY"));
    
    OrderDAO orderDAO = new OrderDAO();
    
    if (orderDAO.insertOrder(orderDTO, userID) != 1) {
    	%><script>
			alert("주문 등록 오류입니다.");
			location.href = "order.jsp";
		</script><%
    }
%>