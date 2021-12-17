package order;

public class OrderDTO {
//    private Long orderNumber;   // 주문번호
//    private String productImage;// 상품이미지
//    private int productInfo; // 상품정보
//    private int quantity;         // 수량
//    private int price;          // 가격
//    private String orderStatus; // 주문처리상태
//    private String orderCancel; // 취소/교환/환불 상태
//

    private String orderNumber;	// o_id
    private Long productNumber;	// s_id
    private int quantity;			// o_quantity
    private int price;			// o_paid
    private String orderDate;		// o_date
    private String status;		// o_status
    private String request;		// o_comment
    private Long tracking;		// o_ship
    private String productName;	// s_name
    private String type;				// o_type
    private String o_ids;
    private String o_qtys;
    private String o_iamport;
    private String o_card;
    private String m_id;

    public OrderDTO(String orderNumber, Long productNumber, int quantity, int price, String orderDate, String status, String request, Long tracking, String type, String productName) {
        this.orderNumber = orderNumber;
        this.productNumber = productNumber;
        this.quantity = quantity;
        this.price = price;
        this.orderDate = orderDate;
        this.status = status;
        this.request = request;
        this.tracking = tracking;
        this.type = type;
		this.productName = productName;
    }
    
    public OrderDTO() {
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public Long getProductNumber() {
        return productNumber;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getPrice() {
        return price;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public String getStatus() {
        return status;
    }

    public String getRequest() {
        return request;
    }

    public Long getTracking() {
        return tracking;
    }

    public String getType() {
        return type;
    }

	public String getProductName() {
		return productName;
	}

	public String getO_ids() {
		return o_ids;
	}

	public String getO_qtys() {
		return o_qtys;
	}

	public void setO_ids(String o_ids) {
		this.o_ids = o_ids;
	}

	public void setO_qtys(String o_qtys) {
		this.o_qtys = o_qtys;
	}

	public String getO_iamport() {
		return o_iamport;
	}

	public String getO_card() {
		return o_card;
	}

	public void setO_iamport(String o_iamport) {
		this.o_iamport = o_iamport;
	}

	public void setO_card(String o_card) {
		this.o_card = o_card;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public void setProductNumber(Long productNumber) {
		this.productNumber = productNumber;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setRequest(String request) {
		this.request = request;
	}

	public void setTracking(Long tracking) {
		this.tracking = tracking;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public void setType(String type) {
		this.type = type;
	}
}
