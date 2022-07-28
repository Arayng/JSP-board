package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn; //�옄諛붿� �뜲�씠�꽣踰좎씠�뒪瑜� �뿰寃�
	private PreparedStatement pstmt; //荑쇰━臾� ��湲� 諛� �꽕�젙
	private ResultSet rs; //寃곌낵媛� 諛쏆븘�삤湲�
	
	//기본생성자
	//UserDAO가 시행되면 자동으로 생성되는 부분
	//硫붿냼�뱶留덈떎 諛섎났�릺�뒗 肄붾뱶瑜� �씠怨녹뿉 �꽔�쑝硫� 肄붾뱶媛� 媛꾩냼�솕�맂�떎
	public UserDAO() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "wwt2d2";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	//濡쒓렇�씤 �쁺�뿭
		public int login(String userID, String userPassword) {
			String sql = "select userPassword from user where userID = ?";
			try {
				pstmt = conn.prepareStatement(sql); //sql荑쇰━臾몄쓣 ��湲� �떆�궓�떎
				pstmt.setString(1, userID); //泥ル쾲吏� '?'�뿉 留ㅺ컻蹂��닔濡� 諛쏆븘�삩 'userID'瑜� ���엯
				rs = pstmt.executeQuery(); //荑쇰━瑜� �떎�뻾�븳 寃곌낵瑜� rs�뿉 ���옣
				if(rs.next()) {
					if(rs.getString(1).equals(userPassword)) {
						return 1; //濡쒓렇�씤 �꽦怨�
					}else
						return 0; //鍮꾨�踰덊샇 ��由�
				}else
				return -1; //�븘�씠�뵒 �뾾�쓬
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -2; //�삤瑜�
		}
		
		//議곗씤 - �쉶�썝媛��엯 �쁺�뿭
		public int join(User user) {
			String sql = "insert into user values(?,?,?,?,?)";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user.getUserID());
				pstmt.setString(2, user.getUserPassword());
				pstmt.setString(3, user.getUserName());
				pstmt.setString(4, user.getUserGender());
				pstmt.setString(5, user.getUserEmail());
				return pstmt.executeUpdate();

			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
}
		
		
		
