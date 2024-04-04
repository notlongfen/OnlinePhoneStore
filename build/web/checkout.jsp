<%-- 
    Document   : checkout
    Created on : Mar 6, 2024, 6:24:06 PM
    Author     : Admin
--%>

<%@page import="sample.sp24.user.UserDTO"%>
<%@page import="sample.sp24.order.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sample.sp24.phone.Phone"%>
<%@page import="sample.sp24.phone.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CHECK OUT</title>
    </head>
    <body>
        <%
            session = request.getSession();
            Boolean check =  (Boolean) session.getAttribute("ORDERED");
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if(check != null){
            if (check == true) {
        %>
        <h1 class="text-success text-center">YOUR ORDER HAVE SUCCESSFULLY PLACED!</h1>
        <%} else {%>
        <h1 class="text-danger text-center">SOME ERROR WITH YOUR ORDER OCCURED!</h1>
        <% }}else{ %>
        <h1 class="text-danger text-center">SOME ERROR WITH YOUR ORDER OCCURED !</h1>
    <%}%>
        <h1>Summary</h1>
        <table border="1" class="table">
            <thead>
                <tr>
                    <th>OrderID</th>
                    <th>ProductID</th>
                    <th>UserID</th>
                    <th>Order Date</th>
                    <th>Total price</th>
                </tr>
            </thead>
            <tbody>
                <%
            ArrayList<ProductDTO> list = (ArrayList<ProductDTO>) session.getAttribute("LIST_ORDERED");
            for(ProductDTO item: list){
            %>
                <tr>
                    
                    <td><%= item.getOrderID() %></td>
                    <td><%= item.getProductID()%></td>
                    <td><%= loginUser.getUserID() %></td>
                    <td><%= item.getPrice()%></td>
                    <td><%= item.getQuantity()%></td>
                    
                </tr>
                <% } %>
            </tbody>
        </table>

    </body>
</html>
