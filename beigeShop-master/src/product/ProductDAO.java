package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProductDAO {

	private static ProductDAO instance = new ProductDAO();

	public static ProductDAO getInstance() {
		return instance;
	}

	public Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");

		String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbID = "scott";
		String dbPassword = "tiger";
		Connection conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		return conn;
	}

	public String getTitleCategory(String category) {
		String title = "ALL ITEMS";
		if (category == null || category.length() == 0) {
			return title;
		}
		switch (category.toLowerCase()) {
		case "zipuphoodie":
			title = "ZIP UP HOODIE";
			break;
		case "coat":
			title = "COAT";
			break;
		case "jacket":
			title = "JACKET";
			break;
		case "shortpants":
			title = "SHORT PANTS";
			break;
		case "denimpants":
			title = "DENIM PANTS";
			break;
		case "joggerpants":
			title = "JOGGER PANTS";
			break;
		case "slacks":
			title = "SLACKS";
			break;
		case "sandal":
			title = "SANDAL";
			break;
		case "slipper":
			title = "SLIPPER";
			break;
		case "boots":
			title = "BOOTS";
			break;
		case "loafers":
			title = "LOAFERS";
			break;
		}

		return title;
	}

	public int insertProduct(ProductDTO product) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int number = 1;
		int re = -1;

		try {
			conn = getConnection();

			sql = "select max(s_id) from beige_shop";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				number = rs.getInt(1) + 1;
			}

			sql = "insert into beige_shop(s_id,s_name,s_size,s_category,s_price,s_stock,s_image,s_image2) values(?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, product.getS_name());
			pstmt.setString(3, product.getS_size());
			pstmt.setString(4, product.getS_category());
			pstmt.setInt(5, product.getS_price());
			pstmt.setInt(6, product.getS_stock());
			pstmt.setString(7, product.getS_image());
			pstmt.setString(8, product.getS_image2());
			pstmt.executeUpdate();
			re = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return re;

	}

	public ArrayList<ProductDTO> listProduct(String pageNumber, String category) {

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "";
		ResultSet pageSet = null;

		ArrayList<ProductDTO> productlist = new ArrayList<ProductDTO>();

		int dbcount = 0;
		int absolutePage = 1;

		try {
			conn = getConnection();

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

			pageSet = stmt.executeQuery("select count(*) from beige_shop"
					+ (category != null ? " where s_category = '" + category + "'" : ""));

			if (pageSet.next()) {
				dbcount = pageSet.getInt(1);
				pageSet.close();
			} // ?? ???? ??

			if (dbcount % ProductDTO.pageSize == 0) {
				ProductDTO.pageCount = dbcount / ProductDTO.pageSize;
			}

			else {
				ProductDTO.pageCount = dbcount / ProductDTO.pageSize + 1;

			}

			if (pageNumber != null) {
				ProductDTO.pageNum = Integer.parseInt(pageNumber);
				absolutePage = (ProductDTO.pageNum - 1) * ProductDTO.pageSize + 1;
			}

//			stmt = conn.createStatement();
			sql = "select * from beige_shop" + (category != null ? " where s_category = '" + category + "'" : "")
					+ " ORDER BY s_id DESC";
			rs = stmt.executeQuery(sql);

			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;

				while (count < ProductDTO.pageSize) {
					ProductDTO product = new ProductDTO();

					product.setS_id(rs.getInt("s_id"));
					product.setS_name(rs.getString("s_name"));
					product.setS_size(rs.getString("s_size"));
					product.setS_category(rs.getString("s_category"));
					product.setS_price(rs.getInt("s_price"));
					product.setS_stock(rs.getInt("s_stock"));
					product.setS_image(rs.getString("s_image"));
					product.setS_image2(rs.getString("s_image2"));
					productlist.add(product);

					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}

					count++;
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return productlist;
	}

	public ProductDTO getProduct(int sid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ProductDTO product = null;

		try {
			conn = getConnection();

			sql = "select * from beige_shop where s_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sid);
			rs = pstmt.executeQuery();

			if (rs.next()) {

				product = new ProductDTO();
				product.setS_id(rs.getInt("s_id"));
				product.setS_name(rs.getString("s_name"));
				product.setS_size(rs.getString("s_size"));
				product.setS_category(rs.getString("s_category"));
				product.setS_price(rs.getInt("s_price"));
				product.setS_stock(rs.getInt("s_stock"));
				product.setS_image(rs.getString("s_image"));
				product.setS_image2(rs.getString("s_image2"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return product;
	}

	public ArrayList<ProductDTO> getSearch(String searchProduct) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = null;

		ArrayList<ProductDTO> list = new ArrayList<ProductDTO>();
		String sql = "select * from beige_shop where s_name like ?";
		try {
			if (searchProduct != null && !searchProduct.equals("")) {

				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + searchProduct + "%");
				rs = pstmt.executeQuery();
				while (rs.next()) {
					product = new ProductDTO();
					product.setS_id(rs.getInt("s_id"));
					product.setS_name(rs.getString("s_name"));
					product.setS_size(rs.getString("s_size"));
					product.setS_category(rs.getString("s_category"));
					product.setS_price(rs.getInt("s_price"));
					product.setS_stock(rs.getInt("s_stock"));
					product.setS_image(rs.getString("s_image"));
					// product.setS_image2(rs.getString("s_image2"));
					list.add(product);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return list;
	}

	public int deleteProduct(String productID) {
		int isDelete = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("DELETE FROM beige_shop WHERE s_id = ?");
			pstmt.setString(1, productID);

			isDelete = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return isDelete;
	}

	public int updateProduct(ProductDTO product) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql1 = "UPDATE beige_shop SET s_name = ?, s_size = ?, s_category = ?, s_price = ?, s_stock = ?";
		String sql2 = " WHERE s_id = " + product.getS_id();
		int isUpdate = -1;

		try {
			conn = getConnection();
			
			if (product.getS_image() != null) {
				sql1 += ", s_image = '" + product.getS_image() + "'";
			}
			if (product.getS_image2() != null) {
				sql1 += ", s_image2 = '" + product.getS_image2() + "'";
			}

			pstmt = conn.prepareStatement(sql1 + sql2);
			pstmt.setString(1, product.getS_name());
			pstmt.setString(2, product.getS_size());
			pstmt.setString(3, product.getS_category());
			pstmt.setInt(4, product.getS_price());
			pstmt.setInt(5, product.getS_stock());
			
			isUpdate = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return isUpdate;
	}

}
