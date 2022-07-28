<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/Custom.css">
<style>
a { 
	color: #000000;
	text-decoration:none;
}
a:hover{
	color: skyblue;
}
</style>
</head>
<body>
<%
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String)session.getAttribute("userID");
}
int boardID = 0;
int pageNumber = 1; // 변수 pageNumber에 기본으로 1을 할당
//만약 파라미터로 넘어온 오브젝트 타입 'pageNumber'가 존재한다면 'int'타입으로 변환 후 그 값을 할당
if(request.getParameter("pageNumber") != null){
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}
if(request.getParameter("boardID") != null){
	boardID = Integer.parseInt(request.getParameter("boardID"));
}
%>
<!-- 네비게이션 -->
	<nav class="navbar navbar-default"> 
	<div class="navbar-header"> 	
	<!-- 네비게이션 상단 박스 영역 -->
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
	<!-- 반응형 아이콘 -->
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
	<!-- 메인 로고 -->
		<a class="navbar-brand" href="main.jsp">HOME</a>
	</div>
	
	<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp">메인</a></li>
<% if (boardID == 1){ %>
			<li class="active"><a href="bbs.jsp?boardID=1&pageNumber=1">게시판 1</a></li>
			<li><a href="bbs.jsp?boardID=2&pageNumber=1">게시판 2</a></li>
<% }else if (boardID == 2){ %>
			<li><a href="bbs.jsp?boardID=1&pageNumber=1">게시판 1</a></li>
			<li class="active"><a href="bbs.jsp?boardID=2&pageNumber=1">게시판2</a></li>
<% } %>
		</ul>		
<%
//비로그인 상태
if(userID == null){
%>
	<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
	<ul class="nav navbar-nav navbar-right">
		<li class="dropdown">
			<a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">메뉴<span class="caret"></span></a>
			<!-- 드랍다운 아이템 영역 -->	
			<ul class="dropdown-menu">
				<li><a href="login.jsp">로그인</a></li>
				<li><a href="join.jsp">회원가입</a></li>
			</ul>
		</li>
	</ul>
<%
//로그인 상태
}else{
%>
	<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
	<ul class="nav navbar-nav navbar-right">
		<li class="dropdown">
			<a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">회원관리<span class="caret"></span></a>
			<!-- 드랍다운 아이템 영역 -->	
			<ul class="dropdown-menu">
				<li><a href="logout.jsp">로그아웃</a></li>
				<!-- <li><a href="join.jsp">회원정보</a></li> -->
			</ul>
		</li>
	</ul>
<% } %>
		</div>
	</nav>
	<div class="container">
	<% if (boardID == 1){ %>
		<h1>게시판 1</h1>
		<p>1번 게시판입니다.</p>
	<% } else if (boardID == 2) { %>
		<h1>게시판 2</h1>
		<p>2번 게시판입니다. </p>
	<% } %>
	</div>
	
	<!-- 게시판 메인페이지영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align:center;">번호</th>
						<th style="background-color:#eeeeee; text-align:center;">제목</th>
						<th style="background-color:#eeeeee; text-align:center;">작성자</th>
						<th style="background-color:#eeeeee; text-align:center;">날짜</th>
					</tr>
				</thead>
				<tbody>
<%
	BbsDAO bbsDAO = new BbsDAO();
	ArrayList<Bbs> list = bbsDAO.getList(boardID, pageNumber);
	for(int i=0; i < list.size(); i++){
%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?boardID=<%=boardID%>&bbsID=<%= list.get(i).getBbsID()%>"><%= list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) %></td>
					</tr>
					
<% } %>
				</tbody>
			</table>
			
	<!-- 페이징 처리 -->
<%
	if (pageNumber != 1){
%>
			<a href="bbs.jsp?boardID=<%=boardID %>&pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
<%
	}
	if(bbsDAO.nextPage(boardID, pageNumber + 1)){
%>
			<a href="bbs.jsp?boardID=<%=boardID %>&pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-right">다음</a>
<% } %>
			
			<!-- 글쓰기 버튼 -->
			<a href="write.jsp?boardID=<%=boardID %>" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<!-- 게시판 메인페이지 영역 끝 -->

<!-- 부트스르랩 참조영역 -->
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>