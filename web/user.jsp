<%-- 
    Document   : user
    Created on : Jan 22, 2024, 9:39:43 AM
    Author     : nguye
--%>

<%@page import="sample.sp24.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>USer Page</title>
    </head>
    <body>
        User page
         <%
            UserDTO loginUser = (UserDTO)session.getAttribute("LOGIN_USER");
             if(loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
             }
            
            %>
            UserID:<%= loginUser.getUserID() %>
            FullName:<%= loginUser.getFullName() %>
            RoleID:<%= loginUser.getRoleID() %>
            Password:<%= loginUser.getPassword() %>
            
    </body>
</html>
