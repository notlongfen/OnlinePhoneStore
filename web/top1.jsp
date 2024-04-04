<%-- 
    Document   : top1
    Created on : Mar 19, 2024, 10:40:16 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
            <%
            String user = (String)session.getAttribute("userID");
            String fullName = (String)session.getAttribute("fullName");
            %>

            <%= user%>
            <%= fullName%>
    </body>
</html>
