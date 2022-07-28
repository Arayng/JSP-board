<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<%@ page import="bbs.Bbs" %>    
<%@ page import="bbs.BbsDAO" %>  
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
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
int boardID = 0;
if(request.getParameter("boardID") != null){
	boardID = Integer.parseInt(request.getParameter("boardID"));
}
int pageNumber = 1;
if(request.getParameter("pageNumber") != null){
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}

int bbsID = 0;
if(request.getParameter("bbsID") != null){
	bbsID = Integer.parseInt(request.getParameter("bbsID"));
}

//게시글 번호가 0인 경우 오류메세지 출력
if(bbsID == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 게시글입니다')");
	script.println("location.href='bbs.jap'");
	script.println("</script>");
	}
// 게시글 정보를 'bbs'라는 객체에 담아 인스턴스화한다
Bbs bbs = new BbsDAO().getBbs(boardID, bbsID);

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
	<!-- 게시글 양식 -->
	<div class="container">
		<div class="row">
			<form method="post" action="writeAction.jsp">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd;">
					<thead>
						<tr>
							<th style="background-color:#eeeeee;text-align:center" colspan="2">
								게시글 양식
							</th>
						</tr>	
					</thead>
					<tbody>
						<tr>
							<td style="width:20%">글제목</td>
							<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=bbs.getUserID()%></td>
						</tr>
						<tr>
							<td>작성일</td>
							<td colspan="2"><%=bbs.getBbsDate().substring(0,11) %></td>
						</tr>
						<tr>
							<td colspan="3">내용</td>
						</tr>
						<tr>
						<%
							String real = "C:\\Users\\Arrr\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\BBS\\bbsUpload";
							File viewFile = new File(real+"\\사진"+bbsID+".jpg");
							if(viewFile.exists()){
						%>
							<td colspan="2" style="height:200px; text-align: left; padding: 30px;">
								<img src="bbsUpload/사진<%=bbsID %>.jpg" style="max-width: 1000px;"><br>
						<% } else { %> <td colspan="2" style="height:200px; text-align: left; padding: 30px;"> <% } %>
								<%=bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%>
							</td>
						</tr>
						
					</tbody>
				</table>
				<a href="bbs.jsp?boardID=<%=boardID %>" class="btn btn-primary">목 록</a>
				<%
					if(userID != null && userID.equals(bbs.getUserID())){ 
				%>
				<a href="update.jsp?boardID=<%=boardID %>&bbsID=<%=bbsID%>" class="btn btn-primary">수 정</a>
				<a onclick="return confirm('게시글을 삭제하시겠습니까?')" href="deleteAction.jsp?boardID=<%=boardID %>&bbsID=<%=bbsID%>" class="btn btn-primary">삭 제</a>
				<% } %>
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