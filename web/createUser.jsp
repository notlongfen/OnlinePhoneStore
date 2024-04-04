<%-- 
    Document   : CreateUser
    Created on : Feb 23, 2024, 11:18:04 AM
    Author     : Admin
--%>

<%@page import="sample.sp24.user.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
            .mxy-10 {
                margin-top: 50px !important;
                margin-left: 400px !important;
                margin-right: 400px !important;

            }
            .bg-gradients{
                background: linear-gradient(to right, #ff7e5f, #feb47b);
            }
        </style>

    </head>
    <body class="bg-gradients">
        <%
            UserError userError = (UserError) request.getAttribute("USER_ERROR");
            if (userError == null) {
                userError = new UserError();
            }
        %>
        <div class="fw-bold fs-3 text-center">Create new user</div>
        <div class="border d-flex justify-content-center mxy-10">
            <form action="MainController" method="POST">
                <div class="d-flex flex-column p-3 text-center">

                    UserID<input type ="text" name="userID" required="" class="form-control"/> 
                    <div class="text-danger">
                        <%=userError.getUserIDError()%>
                    </div>



                    Full Name <input type ="text" name="fullName" required="" class="form-control"/>
                    <div class="text-danger">
                        <%=userError.getFullNameError()%>
                    </div>
                    <div class="p-2">
                Role ID: <select name ="roleID">
                    <option value="AD">AD</option>
                    <option value="US">US</option>
                </select><br>
                    </div>
                Password<input type ="password" name="password" required="" class="form-control"/><br>
                Confirm <input type ="password" name="confirm" required="" class="form-control"/><br> 
                <div class="text-danger pb-2">
                    <%=userError.getConfirmError()%>
                </div>
                </div>

        </div>
        <div class="d-flex justify-content-center">
            <input type ="submit" name="action" value="Create" class="btn btn-primary"/><br>
            <input type="reset" name="Reset" class="btn btn-danger"/> <br>
        </div>
    </form>
    <%= userError.getError()%>
</div>
</body>
</html>
