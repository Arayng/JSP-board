<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}	
%>

		<nav class="navbar navbar-default"> <!-- 네비게이션 -->
		<div class="navbar-header"> 	<!-- 네비게이션 상단 부분 -->
		<!-- 네비게이션 상단 박스 영역 -->
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
		<a class="navbar-brand" href="main.jsp">HOME</a>
	</div>
	
	<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li class="active"><a href="main.jsp">메인</a></li>
			<li><a href="bbs.jsp?boardID=1&pageNumber=1">게시판1</a></li>
			<li><a href="bbs.jsp?boardID=2&pageNumber=1">게시판2</a></li>

		</ul>
				
<%
	//로그인 하지 않았을때의 화면
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
	//로그인이 되어 있는 상태
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
	<!-- 메인 영역 -->
	<div class="container">		<!-- 하나의 영역 생성 -->
		<div class="col-lg-2"></div>
		<div class="col-lg-8">	<!-- 영역 크기 -->
			<!-- 점보트론은 특정 컨텐츠, 정보를 두드러지게 하기 위한 큰 박스 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<h1>기본 게시판을 직접 <br>JSP를 이용해 <br> 개발해보았습니다</h1>
			</div>
		</div>	
		<div class="col-lg-2"></div>
	</div>
	
	
<!-- 부트스르랩 참조영역 -->
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>