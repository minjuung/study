<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

	<style type="text/css">
			li {list-style: none; float: left; padding: 6px;}
		</style>
</head>
<body>
<!-- �˻� -->
<form role="form" method="get">
<div class="search">
    <select name="searchType">
      <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>����</option>
      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>����</option>
      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>�ۼ���</option>
    </select>

    <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}"/>

    <button id="searchBtn" type="submit">�˻�</button>
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
		<c:forEach items="${list}" var="dto">
			<tr>
				<td>${dto.b_id}</td>
				<td>${dto.b_name}</td>
				<td>
					<a href="content_view?b_id=${dto.b_id}">${dto.b_title}</a>
				</td>
				<td>${dto.b_date}</td>
				<td>${dto.b_up}</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="5"> 
				<a href="write_view">���ۼ�</a>
			</td>
		</tr>
		
	
	</table>
	
	<!--����¡ó��  -->
		<div>
  <ul>
    <c:if test="${pageMaker.prev}">
    	<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">����</a></li>
    </c:if> 

    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    	<li><a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
    </c:forEach>

    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    	<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">����</a></li>
    </c:if> 
  </ul>
</div>
</body>
</html>