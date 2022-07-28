<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/Custom.css">
</head>
<body>

<!-- 세션 등 기본 확인 영역 -->
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
// 로그인이 되어있지 않은경우 안내문 출력
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");	
		script.println("alert('로그인을 해주세요')");	
		script.println("history.back()");	
		script.println("</script>");	
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
// 세션 아이디와 게시글 아이디가 다른 경우 오류 출력
	Bbs bbs = new BbsDAO().getBbs(boardID, bbsID);
	if(!userID.equals(bbs.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");	
		script.println("alert('권한이 없습니다.')");	
		script.println("history.back()");	
		script.println("</script>");
	}
		
%>
<!--  세션 등 기본 확인 영역 끝 -->
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
		<a class="navbar-brand" href="main.jsp">맷쥡</a>
	</div>
	
	<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp">메인</a></li>
<% if (boardID == 1){ %>
			<li class="active"><a href="bbs.jsp?boardID=1&pageNumber=1">맛집 평가</a></li>
			<li><a href="bbs.jsp?boardID=2&pageNumber=1">자유게시판</a></li>
<% }else if (boardID == 2){ %>
			<li><a href="bbs.jsp?boardID=1&pageNumber=1">맛집 평가</a></li>
			<li class="active"><a href="bbs.jsp?boardID=2&pageNumber=1">자유게시판</a></li>
<% } %>
		</ul>

	<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
				<!-- 드랍다운 아이템 영역 -->	
				<ul class="dropdown-menu">
					<li><a href="logout.jsp">로그아웃</a></li>
					<li><a href="join.jsp">회원정보</a></li>
				</ul>
			</li>
		</ul>
	</div>
	</nav>
	<!-- 네비게이션 영역 끝 -->
	<!-- 게시글 수정 양식 시작 -->
	<div class="container">		<!-- 하나의 영역 생성 -->
		<div class="row">
			<form method="post" action="updateAction.jsp?boardID=<%=boardID %>&bbsID=<%=bbsID%>">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd;">
					<thead>
						<tr>
							<th style="background-color:#eeeeee;text-align:center">
								게시글 수정
							</th>
						</tr>	
					</thead>
					<tbody>
						<tr>
							<td>
								<input type="text" class="form-control" placeholder="제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>">
							</td>
						</tr>
						<tr>
							<td>
								<textarea class="form-control" placeholder="내용" name="bbsContent" maxlength="2048" style="height:500px;"><%= bbs.getBbsContent()%></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="수 정">
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