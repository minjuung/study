<%@page import="java.text.DecimalFormat"%>
<%@ page import="order.OrderDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="order.OrderDTO" %>
<%@ page import="java.util.ArrayList" %>
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
            <h4>Order List</h4>
            <div class="col-md-10" id="tables">
                <p>> 주문내역조회</p>
            </div>
            <div>
                <form method="post" action="order.jsp?<%=request.getParameter("date")%>">
                    <%--                    <input type="text" class="selector" placeholder="날짜를 선택하세요." />--%>
                    <%--                    <a class="input-button" title="toggle" data-toggle><i class="icon-calendar"></i></a> ~--%>
                    <table>
                        <tr>
                            <td>
                                <input type="text" class="selectors" name="startDate" placeholder="날짜를 선택하세요."/>
                                <a class="input-button" title="toggle" data-toggle><i class="icon-calendar"></i></a>
                            </td>
                            <td>
                                ~
                            </td>
                            <td>
                                <input type="text" class="selectors1" name="endDate" placeholder="날짜를 선택하세요."/>
                                <a class="input-button" title="toggle" data-toggle><i class="icon-calendar"></i></a>
                            </td>
                            <td>
                                <button type="submit" class="btn btn-secondary btn-sm" id="check" name="check">조회
                                </button>
                            </td>
                        </tr>
                    </table>

                    <%--                    <input class="flatpickr flatpickr-input" type="text" placeholder="Select Date.." data-id="rangePreload" readonly="readonly">--%>


                    <%--        onclick="location.href='https://www.google.com/'"--%>
                </form>
            </div>
            <div>
                <%

                    String requestStartDate = request.getParameter("startDate");
                    String requestEndDate = request.getParameter("endDate");
                    List<OrderDTO> orderDTOList;
                    OrderDAO orderDAO = new OrderDAO();
                    
                    DecimalFormat dc = new DecimalFormat("###,###,###");

                    System.out.println("requestStartDate = " + requestStartDate);
                    System.out.println("requestEndDate = " + requestEndDate);
                    if (requestStartDate != null) {

                        orderDTOList = orderDAO.viewOrderTwoDate(String.valueOf(session.getAttribute("userID")), requestStartDate, requestEndDate);

                %>
            </div>
            <div class="container-fluid">
                <div class="mt-3">
                    <table id="orderLists" class="table">
                        <thead>
                        <tr>
                            <td>주문번호</td>
                            <td>주문일자</td>
                            <td>주문명</td>
                            <!-- <td>수량</td> -->
                            <td>가격</td>
                            <td>주문처리상태</td>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                        	if (orderDTOList.size() == 0) {
                        		%>
                    		<tr align="center">
                    			<td colspan="5">주문 내역이 없습니다.</td>
                    		</tr>
                        		<%
                        	} else {

                            	for (int i = 0; i < orderDTOList.size(); i++) {

                        %>
	                        <tr>
	                            <td>
	                                <a href="orderDetail.jsp?orderNumber=<%=orderDTOList.get(i).getOrderNumber()%>"><%=orderDTOList.get(i).getOrderNumber()%>
	                            </td>
	                            <td><%=orderDTOList.get(i).getOrderDate()%>
	                            </td>
	                            <td>
	                            	<a href="shopShow.jsp?s_id=<%= orderDTOList.get(i).getProductNumber() %>"><%=orderDTOList.get(i).getProductName()%></a>
	                            </td>
	                            <%-- <td><%=orderDTOList.get(i).getQuantity()%> --%>
	                            </td>
	                            <td align="right"><%= dc.format(orderDTOList.get(i).getPrice()) %>
	                            </td>
	                            <td><%=orderDTOList.get(i).getStatus()%>
	                            </td>
	                        </tr>
                        <%
                           		}
                        	}
                        %>
                        </tbody>
                    </table>

                    <%


                    } else {
                    %>
                    날짜를 선택해주세요.
                    <%
                        }


                    %>
                </div>

            </div>
            <div>
                <%

                %>

            </div>

<script type="text/javascript">//
//     $(".selector").flatpickr({
//     dateFormat: "Y-m-d",
//     themes: "airbnb",
//     // minDate:"today",
//     defaultDate: "today",
//     maxDate: new Date().fp_incr(60)
//
// });
$(".selectors").flatpickr({
    // mode: "range",
    altInput: true,
    altFormat: "Y, F j",
    dateFormat: "Y-m-d H:i",
    defaultDate: "today"

});
$(".selectors1").flatpickr({
    // mode: "range",
    altInput: true,
    altFormat: "Y, F j",
    dateFormat: "Y-m-d 23:59",
    defaultDate: "today"


});

// $(function(){
//     $("#checks").click(function(){
//         $.ajax({
//             url : 'order.jsp', //데이터베이스에 접근해 현재페이지로 결과를 뿌려줄 페이지
//             method : 'post',
//             data : {
//                 userId : 'userID' //dbGet.jsp페이지로 데이터를 보냄
//             },
//             success : function(data){ //DB접근 후 가져온 데이터
//                 var list = [];
//
//                 list.push(data);
//                 console.log($.trim(item)); //jsp페이지 통째로 가져오다보니 공백을 자를 필요가 있음.
//                 // document.write($.trim(item)); //jsp페이지 통째로 가져오다보니 공백을 자를 필요가 있음.
//             }
//         })
//     })
// })


<%--</script>--%>

</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

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
