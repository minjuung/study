<!-- 경로 :  C:\Users\USER\eclipse-workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\wpqkf\upload
	upload폴더를 컴퓨터 별 이클립스 워크스페이스 폴더에 만들어야 제대로 작동합니다!!!!!
	컴퓨터마다 경로가 조금씩 다르니 주의!!!!
-->


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
MultipartRequest multi = new MultipartRequest(request,path,size, "utf-8",policy);
Enumeration files = multi.getFileNames();
String str = (String)files.nextElement();
file = multi.getFilesystemName(str);

String str2 = (String)files.nextElement();
String file2 = multi.getFilesystemName(str2);

if(file != null){
	oriFile = multi.getOriginalFileName(str);
	fileSize = file.getBytes().length;
	
}

	//SmartUpload upload = new SmartUpload();
	//upload.initialize(pageContext);
	//upload.upload();
	
	//String fName = null;
	//int fSize=0;
	
	//File file = upload.getFiles().getFile(0);
	
	//if(!file.isMissing()){
		//fName = file.getFileName();
		//fSize = file.getSize();
		//file.saveAs("/upload/"+file.getFileName());
	//}


ProductDTO product = new ProductDTO();

product.setS_id(Integer.parseInt(multi.getParameter("s_id")));
product.setS_name(multi.getParameter("s_name"));
product.setS_size(multi.getParameter("s_size"));
product.setS_category(multi.getParameter("s_category"));
product.setS_price(Integer.parseInt(multi.getParameter("s_price")));
product.setS_stock(Integer.parseInt(multi.getParameter("s_stock")));
product.setS_image(file2);
product.setS_image2(file);


ProductDAO db = ProductDAO.getInstance();
if(db.insertProduct(product) ==1){
	
	response.sendRedirect("shopList.jsp");
}

else {
	response.sendRedirect("shopWrite.jsp");
}
%>
</body>
</html>