package cart;

import order.OrderDTO;
import user.UserDTO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

	private ResultSet rs;
	private PreparedStatement pstmt;
	private Connection conn;
	private List<CartDTO> cartDTOList = new ArrayList<>();

	public CartDAO() {
		try {
			conn = getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");

		String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbID = "scott";
		String dbPassword = "tiger";
		Connection conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		return conn;
	}

	public void dbOpen() {
		try {
			dbClose();
			
			conn = getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void dbClose() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("dbClose() Exception!!!");
		}
	}

	public int addCart(CartDTO cart) {
		int isAdd = -1;

		try {
			dbOpen();
			pstmt = conn
					.prepareStatement("INSERT INTO beige_cart (m_id, s_id, c_amount, c_date) VALUES(?, ?, ?, sysdate)");
			pstmt.setString(1, cart.getmId());
			pstmt.setInt(2, cart.getsId());
			pstmt.setInt(3, cart.getcAmount());

			isAdd = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return isAdd;
	}

	public CartDTO viewShop(int shopNumber) {
		String SQL = "SELECT * FROM beige_shop WHERE s_id = ?";
		try {
			dbOpen();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, shopNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int sId = rs.getInt("s_id");
				String sName = rs.getString("s_name");
				String sImage = rs.getString("s_image");
				String sCategory = rs.getString("s_category");
				int sPrice = rs.getInt("s_price");
				int sStock = rs.getInt("s_stock");
				String sSize = rs.getString("s_size");

				CartDTO cartDTO = new CartDTO(sId, sName, sImage, sCategory, sPrice, sStock, sSize);

				return cartDTO;
			}

//            return -1; //아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return null;
	}

	public boolean isCart(String userId, int s_id) {
		boolean isCart = false;
		String SQL = "SELECT * FROM beige_cart c, beige_shop s WHERE m_id = ? AND c.s_id = s.s_id AND s.s_id = ?";
		try {
			dbOpen();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userId);
			pstmt.setInt(2, s_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				isCart = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return isCart;
	}

	public List<CartDTO> viewCart(String userId) {
		String SQL = "SELECT * FROM beige_cart c, beige_shop s WHERE m_id = ? AND c.s_id = s.s_id";
		try {
			dbOpen();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String mId = rs.getString("m_id");
				int sId = rs.getInt("s_id");
				int cAmount = rs.getInt("c_amount");
				String sType = rs.getString("s_category");
				int sPrice = rs.getInt("s_Price");
				String cDate = rs.getString("c_Date");

				CartDTO cartDTO = new CartDTO(mId, sId, cAmount, sType, sPrice, cDate);
				cartDTOList.add(cartDTO);
			}
			return cartDTOList;

//            return -1; //아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return null;
	}

	public int deleteCart(int sId, String mId) {
		String SQL = "DELETE FROM beige_cart WHERE s_id = ? AND m_id = ?";
		try {
			dbOpen();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, sId);
			pstmt.setString(2, mId);
			pstmt.executeUpdate();

			return 1;

//            return -1; //아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return -1;
	}
}