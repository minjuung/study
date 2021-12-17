<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="search.js" charset="utf-8"></script>
</head>
<body>
	<form name="form" method="post" action="search">
		<div>
			<input type="text" name="search" placeholder="�˻�">
			<div>
				<input type="submit" value="�˻�" >
			</div>
		</div>
	</form>
	<table width="500" border="1">
		<tr>	
			<td>��ȣ</td>
			<td>�̸�</td>
			<td>����</td>
			<td>��¥</td>
			<td>��Ʈ</td>
		</tr>
		<c:forEach items="${hitBest}" var="dto">
			<tr>
				<td>${dto.bId}</td>
				<td>${dto.bName}</td>
				<td>
					<a href="content_view?bId=${dto.bId}">${dto.bTitle}</a>
				</td>
				<td>${dto.bDate}</td>
				<td>${dto.bHit}</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="5"> 
				<a href="write_view">���ۼ�</a>
			</td>
		</tr>
	</table>
</body>
</html>