package order;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;

public class OrderDAO {
    private ResultSet rs;
    private PreparedStatement pstmt;
    private Connection conn;
    private List<String> list = new ArrayList<>();
    private List<OrderDTO> orderDTOList = new ArrayList<>();

    public OrderDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

/*
    public List<OrderDTO> viewOrderOneDate(String userID, String inputOrderDate) {
//        List<OrderDTO> orderDTOList = null;
        String SQL = "SELECT * FROM ORDERLIST WHERE ID = ? AND ORDERDATE = ?";
        try {
        	dbOpen();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.setString(2, inputOrderDate);
            rs = pstmt.executeQuery();
            while (rs.next()) {

                String id = rs.getString("ID");
                String orderNo = rs.getString("ORDERNO");
                Long productNo = rs.getLong("PRODUCTNO");
                int quantity = rs.getInt("QUANTITY");
                int price = rs.getInt("PRICE");
                String orderDate = rs.getString("ORDERDATE");
                String status = rs.getString("STATUS");
                String request = rs.getString("REQUEST");
                Long tracking = rs.getLong("TRACKING");
//                OrderDTO orderDTO = new OrderDTO(orderNo, productNo, quantity, price, orderDate, status, request, tracking, );
//                orderDTOList.add(orderDTO);
                System.out.println("orderDTOList.size = " + orderDTOList.size());
            }
            return orderDTOList;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbClose();
        }
        return null;
    }
*/

    public List<OrderDTO> viewOrderTwoDate(String userID, String OrderStartDate, String OrderEndDate) {
//        List<OrderDTO> orderDTOList = null;
//        String SQL = "SELECT * FROM ORDERLIST WHERE ID = ? AND ORDERDATE BETWEEN ? AND ?";
        String SQL = "select o.m_id" +
                "     , o_id" +
                "     , o.s_id" +
                "     , o_quantity" +
                "     , o_price" +
                "     , TO_CHAR(o_date, 'yyyy-mm-dd hh24:mi:ss') AS o_date" +
                "     , o_status" +
                "     , o_comment" +
                "     , o_ship" +
                "     , o_type" +
                "     , s.s_name" +
                "     , o.s_ids" +
                "     from beige_order o, beige_shop s" +
                "     WHERE m_id = ? AND o.s_id = s.s_id " +
                "    AND o_date BETWEEN TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS')" +
                "    ORDER BY o_date DESC";
        try {
        	dbOpen();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.setString(2, OrderStartDate);
            pstmt.setString(3, OrderEndDate);
            rs = pstmt.executeQuery();
            while (rs.next()) {

                String id = rs.getString("m_id");
                String orderNo = rs.getString("o_id");
                Long productNo = rs.getLong("s_id");
                int quantity = rs.getInt("o_quantity");
                int price = rs.getInt("o_price");
                String orderDate = rs.getString("o_date");
                String status = rs.getString("o_status");
                String request = rs.getString("o_comment");
                Long tracking = rs.getLong("o_ship");
                String type = rs.getString("o_type");
                String productName = rs.getString("s_name");
                if (rs.getString("s_ids").split(",").length > 1) {
                	productName += (" <i>외 " + (rs.getString("s_ids").split(",").length - 1) + "건</i>");
                }
                OrderDTO orderDTO = new OrderDTO(orderNo, productNo, quantity, price, orderDate, status, request, tracking, type, productName);
                orderDTOList.add(orderDTO);
            }
            return orderDTOList;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbClose();
        }
        return null;
    }


    public OrderDTO orderDetailView(String orderNumber) {
//        List<OrderDTO> orderDTOList = null;
        String SQL = "SELECT * FROM beige_order o, beige_shop s WHERE o_id = ? AND o.s_id = s.s_id";
        OrderDTO orderDTO = null;
        try {
        	dbOpen();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, orderNumber);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                String id = rs.getString("m_id");
                String orderNo = rs.getString("o_id");
                Long productNo = rs.getLong("s_id");
                int quantity = rs.getInt("o_quantity");
                int price = rs.getInt("o_price");
                String orderDate = rs.getString("o_date");
                String status = rs.getString("o_status");
                String request = rs.getString("o_comment");
                Long tracking = rs.getLong("o_ship");
                String type = rs.getString("o_type");
                String productName = rs.getString("s_name");
                orderDTO = new OrderDTO(orderNo, productNo, quantity, price, orderDate, status, request, tracking, type, productName);
                orderDTO.setM_id(id);
                orderDTO.setO_ids(rs.getString("s_ids"));
                orderDTO.setO_qtys(rs.getString("o_quantities"));
//                orderDTOList.add(orderDTO);
//                System.out.println("orderDTOList.size = " + orderDTOList.size());
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbClose();
        }
        return orderDTO;
    }
    
    public ArrayList<OrderDTO> viewOrders() {
    	ArrayList<OrderDTO> orders = new ArrayList<OrderDTO>();
    	String sql = "SELECT o_id, o_date, m_id, s_ids, o_quantities, o_price, o_status, o_type, o_ship FROM beige_order ORDER BY o_ship ASC, o_date ASC";
    	
    	try {
    		dbOpen();
    		
    		pstmt = conn.prepareStatement(sql);
    		rs = pstmt.executeQuery();
    		
    		while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderNumber(rs.getString("o_id"));
                order.setOrderDate(rs.getString("o_date"));
                order.setM_id(rs.getString("m_id"));
                order.setO_ids(rs.getString("s_ids"));
                order.setO_qtys(rs.getString("o_quantities"));
                order.setPrice(rs.getInt("o_price"));
                order.setStatus(rs.getString("o_status"));
                order.setType(rs.getString("o_type"));
                order.setTracking(rs.getLong("o_ship"));
                
                orders.add(order);
    		}
    		
    	} catch (Exception e) {
    		e.printStackTrace();
		} finally {
			dbClose();
		}
    	
    	return orders;
    }
    
    public int insertOrder(OrderDTO order, String userID) {
    	int isInsert = -1;
    	String sql = "INSERT INTO beige_order ( " + 
				"o_id, m_id, s_id, o_quantity, o_price, s_ids, o_quantities, o_type, o_comment, o_ship, o_status, o_date, o_iamport, o_card ) VALUES ( " + 
    			"?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )"; // 14
    	try {
    		dbOpen();
    		pstmt = conn.prepareStatement(sql);
    		// o_id
    		pstmt.setString(1, order.getOrderNumber());
    		// m_id
    		pstmt.setString(2, userID);
    		// s_id
    		pstmt.setInt(3, order.getProductNumber().intValue());
    		// o_quantity
    		pstmt.setInt(4, order.getQuantity());
    		// o_price
    		pstmt.setInt(5, order.getPrice());
			// s_ids
			pstmt.setString(6, order.getO_ids());
			// o_quantities
			pstmt.setString(7, order.getO_qtys());
    		// o_type
    		pstmt.setString(8, order.getType());
    		// o_comment
    		pstmt.setString(9, order.getRequest());
    		// o_ship
    		pstmt.setLong(10, order.getTracking());
    		// o_status
    		pstmt.setString(11, order.getStatus());
    		// o_date
    		pstmt.setTimestamp(12, new Timestamp(System.currentTimeMillis()));
    		// o_iamport
    		pstmt.setString(13, order.getO_iamport());
    		// o_card
    		pstmt.setString(14, order.getO_card());
    		
    		isInsert = pstmt.executeUpdate();
    		if (isInsert == 1) {
    			afterOrderDeleteCart(userID);
    			
    			JSONParser parser = new JSONParser();
    			JSONArray items = (JSONArray) parser.parse(order.getO_ids());
    			JSONArray qtys = (JSONArray) parser.parse(order.getO_qtys());
    			
    			for (int i = 0; i < items.size(); i++) {
    				afterOrderEditShop(Integer.parseInt(items.get(i).toString()), Integer.parseInt(qtys.get(i).toString()));
    			}
    		}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
            dbClose();
        }
    	
    	return isInsert;
    }
    
    public void afterOrderDeleteCart(String m_id) {
    	String sql = "DELETE FROM beige_cart WHERE m_id = ?";
    	try {
    		dbOpen();
    		
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, m_id);
    		pstmt.executeUpdate();    		
    	} catch (Exception e) {
    		e.printStackTrace();
		} finally {
			dbClose();
		}
    }
    
    public void afterOrderEditShop(int s_id, int s_qty) {
    	String sql = "UPDATE beige_shop SET s_stock = s_stock - ? WHERE s_id = ?";
    	try {
    		dbOpen();
    		
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, s_qty);
    		pstmt.setInt(2, s_id);
    		pstmt.executeUpdate();    		
    	} catch (Exception e) {
    		e.printStackTrace();
		} finally {
			dbClose();
		}
    }

    public int updateStatus(String o_id, Long o_ship) {
    	int isUpdate = -1;
    	String sql = "UPDATE beige_order SET o_ship = ?, o_status = ? WHERE o_id = ?";
    	try {
    		dbOpen();
    		
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setLong(1, o_ship);
    		pstmt.setString(2, "발송 완료");
    		pstmt.setString(3, o_id);
    		isUpdate = pstmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
		} finally {
			dbClose();
		}
    	
    	return isUpdate;
    }

    public void dbClose() {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("dbClose() Exception!!!");
        }
    }
    
    public void dbOpen() {
    	try {
			dbClose();
			
			conn = getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    public Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");

		String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbID = "SCOTT";
		String dbPassword = "TIGER";
		Connection conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		return conn;
	}
}
