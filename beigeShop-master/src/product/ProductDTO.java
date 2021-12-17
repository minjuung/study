package product;

public class ProductDTO {
	private int s_id;
	private String s_name;
	private String s_size;
	private String s_category;
	private int s_price;
	private int s_stock;
	private String s_image;
	private String s_image2;
	
	
	public static int pageSize = 10; // 페이지당 글 개수
	public static int pageCount = 1;  // 페이지 개수
	public static int pageNum = 1; //각 페이지 번호
	
	public static String pageNumber(int limit, String page) {
		String str ="";
		int temp =(pageNum - 1) % limit;//임시 시작페이지
		int startPage = pageNum - temp;//시작페이지
		
		if((startPage - limit) > 0) {
			str = "<a href ='" + page + "?pageNum="+(startPage-1)+"'>[이전]</a>&nbsp;&nbsp;";
		}//이전 출력
		
		for (int i = startPage; i < (startPage+limit); i++) {
			if (i == pageNum) {
				str += "["+i+"]&nbsp;&nbsp;";
			}else {
				str += "<a href='" + page + "?pageNum="+i+"'>["+i+"]</a>&nbsp;&nbsp;";
			}
			if (i >= pageCount) {
				break;
			}
		}
		if((startPage + limit) <= pageCount) {
			str += "<a href ='" + page + "?pageNum="+(startPage+limit)+"'>[다음]</a>&nbsp;&nbsp;";
		}//다음 출력
		return str;
	}
	
	public int getS_id() {
		return s_id;
	}
	public void setS_id(int s_id) {
		this.s_id = s_id;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public String getS_size() {
		return s_size;
	}
	public void setS_size(String s_size) {
		this.s_size = s_size;
	}
	public String getS_category() {
		return s_category;
	}
	public void setS_category(String s_category) {
		this.s_category = s_category;
	}
	public int getS_price() {
		return s_price;
	}
	public void setS_price(int s_price) {
		this.s_price = s_price;
	}
	public int getS_stock() {
		return s_stock;
	}
	public void setS_stock(int s_stock) {
		this.s_stock = s_stock;
	}
	public String getS_image() {
		return s_image;
	}
	public void setS_image(String s_image) {
		this.s_image = s_image;
	}
	
	public String getS_image2() {
		return s_image2;
	}
	
	public void setS_image2(String s_image2) {
		this.s_image2 = s_image2;
	}
}
