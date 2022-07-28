<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<form action = "file_Ex01_upload.jsp" method="post" enctype="multipart/form-data">
		<fieldset>
		<legend class="form from-default">파일 업로드</legend>
		<p>작성자 : <input type="text" name="userName"></p>
		<p>파일명 : <input type="file" name="file"></p>
		<p><input type="submit" value="upload"></p>
		</fieldset>
	</form>
	<br><hr><br>
	
	<fieldset>
		<legend>파일 다운로드</legend>
		<table border="1">
			<tr>
				<th>이 미 지</th>
				<th>이미지 설명</th>
				<th>다운로드</th>
			</tr>
			<tr>
				<td><img src="../img/404.png" alt="404이미지" width="140px" height="100px"></td>
				<td align="center" width="200">404에러 이미지</td>
				<td align="center" width="200"><a href="file_Ex01_download.jsp?fileName=404.png">다운로드</a></td>
			</tr>
			<tr>
				<td><img src="../img/500.png" alt="500이미지" width="140px" height="100px"></td>
				<td align="center" width="200">500에러 이미지</td>
				<td align="center" width="200"><a href="file_Ex01_download.jsp?fileName=500.png">다운로드</a></td>
			</tr>
		</table>
	</fieldset>
</body>
</html>