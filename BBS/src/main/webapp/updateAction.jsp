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

	int bbsID = 0;
	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	
	int boardID = 0;
    if(request.getParameter("boardID") != null){
    	boardID = Integer.parseInt(request.getParameter("boardID"));
    }
 // 게시글 번호가 0 번인 경우 오류 출력
	if(bbsID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");	
		script.println("alert('게시글이 없습니다.')");	
		script.println("history.back()");	
		script.println("</script>");
	}

	bbs = new BbsDAO().getBbs(boardID, bbsID);
// 세션 아이디와 게시글 아이디가 다른 경우 오류 출력
	if(!userID.equals(bbs.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");	
		script.println("alert('권한이 없습니다.')");	
		script.println("history.back()");	
		script.println("</script>");
	}else{
// 입력이 안 되었거나 빈칸만 있는지 체크
		if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null || request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		}else{
// 정상적으로 입력이 되었다면 게시글 수정 로직을 수행한다
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.update(boardID, bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
// 데이터베이스 오류인 경우
			if(result == -1){
			   PrintWriter script = response.getWriter();
			   script.println("<script>");
			   script.println("alert('글 수정 실패')");
			   script.println("history.back()");
			   script.println("</script>");
// 수정이 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
			}else{
			   PrintWriter script = response.getWriter();
			   script.println("<script>");
			   script.println("alert('수정 완료')");
			   script.println("location.href='view.jsp?boardID="+boardID+"&bbsID="+bbsID+"'");
			   script.println("</script>");
			}
		}
	} 
  
%>
</body>
</html>