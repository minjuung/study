package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
	private static BoardDAO boardDAO;

	public static BoardDAO getInstance() {
		if (boardDAO == null) {
			boardDAO = new BoardDAO();
		}
		return boardDAO;
	}

	public Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");

		String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbID = "scott";
		String dbPassword = "tiger";
		Connection conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		return conn;
	}

	public BoardDTO getBoard(int b_id, boolean isView) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO board = null;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM beige_board WHERE b_id = ?");
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new BoardDTO();
				int view = rs.getInt("b_view");
				
				if (isView) {
					view++;
					conn.prepareStatement("UPDATE beige_board SET b_view = " + view + " WHERE b_id = " + b_id).executeUpdate();
				}
				
				board.setB_id(rs.getInt("b_id"));
				board.setM_id(rs.getString("m_id"));
				board.setB_category(rs.getString("b_category"));
				board.setB_view(view);
				board.setB_title(rs.getString("b_title"));
				board.setB_content(rs.getString("b_content"));
				board.setB_date(rs.getTimestamp("b_date"));
				board.setB_secret(rs.getString("b_secret"));
				board.setB_ref(rs.getInt("b_ref"));
			}
		} catch (Exception e) {
			return null;
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}

		return board;
	}
	
	public ArrayList<BoardDTO> getList(String b_category) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardDTO> boards = new ArrayList<BoardDTO>();

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM beige_board WHERE b_category = ? order by b_ref desc, b_id asc");
			pstmt.setString(1, "공지");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setB_id(rs.getInt("b_id"));
				board.setM_id(rs.getString("m_id"));
				board.setB_category(rs.getString("b_category"));
				board.setB_view(rs.getInt("b_view"));
				board.setB_title(rs.getString("b_title"));
				board.setB_content(rs.getString("b_content"));
				board.setB_date(rs.getTimestamp("b_date"));
				board.setB_secret(rs.getString("b_secret"));
				board.setB_ref(rs.getInt("b_ref"));

				boards.add(board);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}

		return boards;
	}

	public ArrayList<BoardDTO> getList() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardDTO> boards = new ArrayList<BoardDTO>();

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM (SELECT * FROM beige_board WHERE b_category = ? ORDER BY b_ref desc, b_id asc) WHERE rownum <= 3");
			pstmt.setString(1, "공지");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setB_id(rs.getInt("b_id"));
				board.setM_id(rs.getString("m_id"));
				board.setB_category(rs.getString("b_category"));
				board.setB_view(rs.getInt("b_view"));
				board.setB_title(rs.getString("b_title"));
				board.setB_content(rs.getString("b_content"));
				board.setB_date(rs.getTimestamp("b_date"));
				board.setB_secret(rs.getString("b_secret"));
				board.setB_ref(rs.getInt("b_ref"));

				boards.add(board);
			}
			pstmt.close();
			rs.close();
			
			pstmt = conn.prepareStatement("SELECT * FROM beige_board WHERE b_category != ? ORDER BY b_ref desc, b_id asc");
			pstmt.setString(1, "공지");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setB_id(rs.getInt("b_id"));
				board.setM_id(rs.getString("m_id"));
				board.setB_category(rs.getString("b_category"));
				board.setB_view(rs.getInt("b_view"));
				board.setB_title(rs.getString("b_title"));
				board.setB_content(rs.getString("b_content"));
				board.setB_date(rs.getTimestamp("b_date"));
				board.setB_secret(rs.getString("b_secret"));
				board.setB_ref(rs.getInt("b_ref"));

				boards.add(board);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}

		return boards;
	}

	public int writeBoard(BoardDTO board) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int isWrite = 0;
		
		try {
			conn = getConnection();
			rs = conn.prepareStatement("SELECT MAX(b_id) FROM beige_board").executeQuery();
			if (rs.next()) {
				board.setB_id(rs.getInt(1) + 1);
			} else {
				board.setB_id(1);
			}
			
			pstmt = conn.prepareStatement("INSERT INTO beige_board "
					+ "(b_id, m_id, b_category, b_view, b_title, b_content, b_date, b_secret, b_ref)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pstmt.setInt(1, board.getB_id());
			pstmt.setString(2, board.getM_id());
			pstmt.setString(3, board.getB_category());
			pstmt.setInt(4, board.getB_view());
			pstmt.setString(5, board.getB_title());
			pstmt.setString(6, board.getB_content());
			pstmt.setTimestamp(7, board.getB_date());
			pstmt.setString(8, board.getB_secret());
			
			int b_ref = board.getB_ref();
			if (b_ref == 0) {
				b_ref = board.getB_id();
			}
			pstmt.setInt(9, b_ref);
			
			isWrite = pstmt.executeUpdate();	
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return isWrite;
	}
	
	public int deleteBoard(int b_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int isDelete = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("DELETE FROM beige_board WHERE b_id = ?");
			pstmt.setInt(1, b_id);
			isDelete = pstmt.executeUpdate();			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return isDelete;
	}
	
	public int editBoard(BoardDTO board) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int isEdit = 0;

		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("UPDATE beige_board SET b_title = ?, b_content = ?, b_secret = ? WHERE b_id = ?");
			pstmt.setString(1, board.getB_title());
			pstmt.setString(2, board.getB_content());
			pstmt.setString(3, board.getB_secret());
			pstmt.setInt(4, board.getB_id());
			
			isEdit = pstmt.executeUpdate();	
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return isEdit;
	}	
}
