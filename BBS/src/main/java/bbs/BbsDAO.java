package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
   private Connection conn;
   private ResultSet rs;
   
   public BbsDAO() {
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

   //작성일자 메소드
   public String getDate() {
      String sql = "select now()";
      try {
         PreparedStatement pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            return rs.getString(1);
         }
         
      }catch (Exception e) {
         e.printStackTrace();
      }
      return "";
      
   }
   
   
   //게시글 번호
      public int getNext() {
         //현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다.
         String sql = "select bbsID from bbs order by bbsID desc";
         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {
               return rs.getInt(1) + 1;
            }
            return 1;  //첫번째 게시물인 경우
            
         }catch (Exception e) {
            e.printStackTrace();
         }
         return -1; //데이터 베이스 오류
         
      }
   
   //글쓰기 메소드
   
   public int write(int boardID, String bbsTitle, String userID, String bbsContent) {
      String sql = "insert into bbs values(?,?,?,?,?,?,?)";
      try {
    	 
         PreparedStatement pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, boardID);
         pstmt.setInt(2, getNext());
         pstmt.setString(3, bbsTitle);
         pstmt.setString(4, userID);
         pstmt.setString(5, getDate());
         pstmt.setString(6, bbsContent);
         pstmt.setInt(7, 1); //글의 유효번호
         return pstmt.executeUpdate();
      }catch (Exception e) {
         e.printStackTrace();
      }
      return -1; //데이터 베이스 오류
   
   }   
   //게시판에 10개의 게시물이 보이게끔 하는 메소드
   public ArrayList<Bbs> getList(int boardID, int pageNumber){
	   String sql = "select * from bbs where boardID = ? && bbsID < ? && bbsAvailable= 1 order by bbsID desc limit 10";
	   ArrayList<Bbs> list = new ArrayList<Bbs>();
	   try {
		   PreparedStatement pstmt = conn.prepareStatement(sql);
		   pstmt.setInt(1, boardID);
		   pstmt.setInt(2, getNext() - (pageNumber -1) * 10);
		   rs = pstmt.executeQuery();
		   while(rs.next()) {
			   Bbs bbs = new Bbs();
			   bbs.setBoardID(rs.getInt(1));
			   bbs.setBbsID(rs.getInt(2));
			   bbs.setBbsTitle(rs.getString(3));
			   bbs.setUserID(rs.getString(4));
			   bbs.setBbsDate(rs.getString(5));
			   bbs.setBbsContent(rs.getString(6));
			   bbs.setBbsAvailable(rs.getInt(7));
			   list.add(bbs);
		   }
		   
	   }catch (Exception e){
		   e.printStackTrace();
	   }
	   return list;
   }
   
   //페이징 처리 메소드
   public boolean nextPage(int boardID, int pageNumber) {
	   String sql = "select * from bbs where boardID = ? && bbsID < ? and bbsAvailable = 1";
	   try {
		   PreparedStatement pstmt = conn.prepareStatement(sql);
		   pstmt.setInt(1, boardID);
		   pstmt.setInt(2, getNext() - (pageNumber -1) * 10);
		   rs = pstmt.executeQuery();
		   if(rs.next()) {
			   return true;
		   }
		   
	   }catch (Exception e){
		   e.printStackTrace();
	   }
	   return false;
   }
   
   //게시글 조회 메소드
   public Bbs getBbs(int boardID, int bbsID) {
	String sql = "select * from bbs where boardID = ? && bbsID = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardID);
		pstmt.setInt(2, bbsID);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			Bbs bbs = new Bbs();
			bbs.setBoardID(rs.getInt(1));
			bbs.setBbsID(rs.getInt(2));
			bbs.setBbsTitle(rs.getString(3));
			bbs.setUserID(rs.getString(4));
			bbs.setBbsDate(rs.getString(5));
			bbs.setBbsContent(rs.getString(6));
			bbs.setBbsAvailable(rs.getInt(7));
			   
		   return bbs;
	   }
		
		
	}catch (Exception e){
		e.printStackTrace();
	}
    return null;
   }
   
   //게시글 수정 메소드
   public int update(int boardID, int bbsID, String bbsTitle, String bbsContent) {
	   String sql = "UPDATE bbs SET bbsTitle = ?, bbscontent = ? where boardID= ? && bbsID = ?";
	   try {
		   PreparedStatement pstmt = conn.prepareStatement(sql);
		   pstmt.setString(1, bbsTitle);
		   pstmt.setString(2, bbsContent);
		   pstmt.setInt(3, boardID);
		   pstmt.setInt(4, bbsID);
		   return pstmt.executeUpdate();
		   
	   }catch ( Exception e) {
		   e.printStackTrace();
	   }
	   return -1;
   }
   
   //게시글 삭제 메소드( bbsAvailable을 수정하는 메소드)
   
   public int delete(int boardID, int bbsID) {
	   String sql = "UPDATE bbs SET bbsAvailable = 0 where boardID = ? && bbsID = ?";
	   try {
		   PreparedStatement pstmt = conn.prepareStatement(sql);
   		   pstmt.setInt(1, boardID);
   		   pstmt.setInt(2, bbsID);
		   return pstmt.executeUpdate();
		   
	   }catch (Exception e){
		   e.printStackTrace();
	   }
	   return -1;
   }
   
}