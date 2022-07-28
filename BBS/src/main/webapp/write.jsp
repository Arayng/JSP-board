<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기본 게시판</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/Custom.css">
</head>
<body>

<!-- 세션 확인 영역 -->
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	int boardID = 0;
	if(request.getParameter("boardID") != null){
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}
%>
<!--  세션 확인 영역 끝 -->

	<nav class="navbar navbar-default"> <!-- 네비게이션 -->
		<div class="navbar-header"> 	<!-- 네비게이션 상단 부분 -->
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
<!-- 글쓰기 양식 시작 -->
	<div class="container">
		<div class="row">
			<form method="post" encType="multipart/form-data" action="writeAction.jsp?boardID=<%=boardID %>">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd;">
					<thead>
						<tr>
							<th style="background-color:#eeeeee;text-align:center">
								게시판 글쓰기 양식
							</th>
						</tr>	
					</thead>
					<tbody>
						<tr>
							<td>
								<input type="text" class="form-control" placeholder="제목" name="bbsTitle" maxlength="50">
							</td>
						</tr>
						<tr>
							<td>
								<textarea class="form-control" placeholder="내용" name="bbsContent" maxlength="2048" style="height:500px;"></textarea>
							</td>
						</tr>
						<tr>
							<td>
								<input type="file" name="fileName">
							</td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>
		<!-- 글쓰기 버튼 -->
		
	</div>
	<!-- 게시판 메인페이지 영역 끝 -->
	
<!-- 부트스르랩 참조영역 -->
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>