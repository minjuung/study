<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="product.ProductDAO"%>
<%@page import="product.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// request.getServletContext().getRealPath("/")
String path = request.getRealPath("upload");
int size = 1024*1024*50;// 50MB
int fileSize = 0;
String file ="";
String oriFile="";

DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
MultipartRequest multi = new MultipartRequest(request,path,size, "utf-8",policy); // 업로드
Enumeration files = multi.getFileNames();
String str = (String)files.nextElement();
file = multi.getFilesystemName(str);
System.out.println("file: " + file);

String str2 = (String)files.nextElement();
String file2 = multi.getFilesystemName(str2);
System.out.println("file2: " + file2);

if(file != null){
	oriFile = multi.getOriginalFileName(str);
	fileSize = file.getBytes().length;
}

ProductDTO product = new ProductDTO();
int s_id = Integer.parseInt(multi.getParameter("s_id"));
product.setS_id(s_id);
product.setS_name(multi.getParameter("s_name"));
product.setS_size(multi.getParameter("s_size"));
product.setS_category(multi.getParameter("s_category"));
product.setS_price(Integer.parseInt(multi.getParameter("s_price")));
product.setS_stock(Integer.parseInt(multi.getParameter("s_stock")));
product.setS_image(file2);
product.setS_image2(file);


ProductDAO db = ProductDAO.getInstance();
if(db.updateProduct(product) == 1){
	%><script>
	alert("상품 정보를 수정하였습니다.");
	location.href = "manageShop.jsp";
	</script><%
}
else {
	%><script>
	alert("상품 수정 오류입니다.");
	history.back();
	</script><%
}
%>
</body>
</html>