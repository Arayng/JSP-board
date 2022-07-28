<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.BbsDAO"%>
<%@page import="bbs.Bbs"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
// 현재 세션 상태를 체크한다
	String userID = null;
	if(session.getAttribute("userID") != null){
	   userID = (String)session.getAttribute("userID");
	}
// 게시글 번호가 0 번인 경우 오류 출력
	int bbsID = 0;
	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	
	int boardID = 0;
	if(request.getParameter("boardID") != null){
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}
	if(bbsID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");	
		script.println("alert('게시글이 없습니다.')");	
		script.println("history.back()");	
		script.println("</script>");
	}
// 세션 아이디와 게시글 아이디가 다른 경우 오류 출력
	bbs = new BbsDAO().getBbs(boardID, bbsID);
	if(!userID.equals(bbs.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");	
		script.println("alert('권한이 없습니다.')");	
		script.println("history.back()");	
		script.println("</script>");
	}else{
// 오류가 없다면 게시글 삭제 로직을 수행한다
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.delete(boardID, bbsID);
// 데이터베이스 오류인 경우
			if(result == -1){
			   PrintWriter script = response.getWriter();
			   script.println("<script>");
			   script.println("alert('글 삭제 실패')");
			   script.println("history.back()");
			   script.println("</script>");
// 게시글 유효번호를 0으로바꾸는 메소드를 실행 후 게시판 메인으로 이동한다
			}else{
			   PrintWriter script = response.getWriter();
			   script.println("<script>");
			   script.println("alert('삭제되었습니다.')");
			   script.println("location.href='bbs.jsp?boardID="+boardID+"'");
			   script.println("</script>");
			}
	}
  
%>
</body>
</html>