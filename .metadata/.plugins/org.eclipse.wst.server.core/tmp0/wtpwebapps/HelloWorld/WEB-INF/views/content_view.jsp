<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table width="500" border="1">
		<form method="post" action="modify">
			<input type="hidden" name="b_id" value="${content_view.b_id}">
			<tr>
				<td>��ȣ</td>
				<td>${content_view.b_id}</td>
			</tr>
			<tr>
				<td>��Ʈ</td>
				<td>${content_view.b_up}</td>
			</tr>
			<tr>
				<td>�̸�</td>
				<td>
					<input type="text" name="b_name" value="${content_view.m_id}">
				</td>
			</tr>
			<tr>
				<td>����</td>
				<td>
					<input type="text" name="b_title" value="${content_view.b_title}">
				</td>
			</tr>
			<tr>
				<td>����</td>
				<td>
					<input type="text" name="b_content" value="${content_view.b_content}">
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<input type="submit" value="����">
					&nbsp;&nbsp;<a href="list">��Ϻ���</a>
					&nbsp;&nbsp;<a href="delete?b_id=${content_view.b_id}">����</a>
				</td>
	
		</form> 
	</table>
<!-- ��ۺ��� -->
	<c:forEach items="${replyList}" var="replyList">
<li>
	<div>
		<p>${replyList.writer} / ${replyList.regdate}</p>
		<p>${replyList.content}</p>
	</div>
</li>	
</c:forEach>

<!-- ��۾��� -->
	<form method="post" action="writeReply">
	
		<input type="hidden" name="bId" value="${content_view.b_id}">
		<p>
			<label>��� �ۼ���</label> <input type="text" name="writer">
		</p>
		<p>
			<textarea rows="5" cols="50" name="content"></textarea>
		</p>
		<p>
			<button type="submit">��� �ۼ�</button>
		</p>
	</form>
	
</div>
	
</body>
</html>