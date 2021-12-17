<%@page import="java.text.DecimalFormat"%>
<%@page import="java.io.File"%>
<%@page import="product.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.ProductDAO"%>
<%@ page import="user.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Beige</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/navbar-static/">


    <!-- Bootstrap core CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">


    <%--    font    --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Anton&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Bree+Serif&family=Sunflower:wght@300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="styles.css"/>
    <link href="sidebars.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/airbnb.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <meta name="theme-color" content="#7952b3">


    <style>

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

    </style>


</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
%>

<%--     NAVI 구역     --%>
<jsp:include page="navi.jsp"/>

<div class="container-fluid">
    <div class="row">

        <%--        SIDEBAR 구역       --%>
        <div class="col-md-2">
            <jsp:include page="sidebar.jsp"/>
        </div>

        <%--        MAIN 구역         --%>
        <div class="col-md-8" id="title">
	<%
		request.setCharacterEncoding("UTF-8");
			String pageNum = request.getParameter("pageNum");
			
			if(pageNum == null){
		pageNum ="1";
			}
		ProductDAO db = ProductDAO.getInstance();
		String searchText = request.getParameter("search");
		ArrayList<ProductDTO> productlist = db.getSearch(searchText);
		
		DecimalFormat format = new DecimalFormat("###,###,###");

		int s_id=0,s_price=0,s_stock=0;
		String s_name, s_size, s_category, s_image;
	%>
		<h4>SEARCH: <%= searchText %></h4>

				<table class="table">
				<tr>
					<td align="right">
						<input type="button"
							value="전체 목록" onClick="location.href='shopList.jsp?pageNum=<%=pageNum%>'"
							style="cursor: pointer;"
							class="btn btn-secondary">
					</td>
				</tr>
			</table>
			<table class="table">	
				<tr height="25">
					<td width="80" align="center">품목</td>
					<td width="80" align="center">이미지</td>
					<td width="450" align="center">상품</td>
					<td width="120" align="center">사이즈</td>
					<td width="130" align="center">가격</td>
					<td width="60" align="center">재고</td>
				</tr>
				
				<%
							if (productlist.size() == 0) {
								%>
								<tr>
									<td colspan="6" align="center">검색 결과가 없습니다. ㅠㅠ</td>
								</tr>
								<%
							} else {
									for(int i = 0; i<productlist.size(); i++){
										
										ProductDTO product = productlist.get(i);
										s_id=product.getS_id();
										s_category=product.getS_category();
										s_name=product.getS_name();
										s_size=product.getS_size();
										s_price=product.getS_price();
										s_stock=product.getS_stock();
										s_image=product.getS_image();
								%>
					<tr height="25" bgcolor="#ffffff" 
									onmouseover="this.style.backgroundColor='#eeeeef'"
									onmouseout="this.style.backgroundColor='#ffffff'"
									onClick="location.href='shopShow.jsp?s_id=<%=s_id%>'"
									style="cursor:pointer;">
						<td align="center"><%=s_category%></td>
						<td><img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%= s_image %>" height="200" width="200"></td>
						<td align="center"><%=s_name%></td>
						<td align="center"><%=s_size%></td>
						<td align="center"><%=format.format(s_price)%></td>
						<td align="center">&nbsp;<%=s_stock%>&nbsp;</td>
					</tr>	
				<%
								}
							}
					%>
			</table>
	    <center>
	   		 <%=ProductDTO.pageNumber(4, "shopSearch.jsp")%>
		</center>	
        </div>
        <jsp:include page="footer.jsp"/>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
        crossorigin="anonymous"></script>
<script src="./js/sidebars.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
</body>
</html>