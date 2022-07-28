<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	//현재 세션 상태를 체크
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	//만약 userID라는 세션이 존재 할 경우 (로그인되어 있는 경우) 사용자에게 sessionID를 부여 하고
	//이미 로그인했으면 다시 록읜할 수 없게 한다.
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어 있습니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	if(result == 1){
		// 로그인에 성공하면 세션을 부여
		session.setAttribute("userID", user.getUserID()); //세션에 로그인아이디를 기억하게 함
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 성공')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}else if(result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다')");
		script.println("history.back()");//이전 페이지(뒤로가기)
		script.println("</script>");
	}else if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다')");
		script.println("history.back()");
		script.println("</script>");
	}else if(result == -2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류입니다')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>
</html>