<%@page import="java.util.List"%>
<%@page import="sample.sp24.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMIN Page</title>
        <style>
            .bg-admin {
                background: linear-gradient(to bottom right, #ff7e5f, #feb47b);
            }

        </style>
    </head>
    <body class="bg-admin">
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
        %>
        <h1>Welcome: <%= loginUser.getFullName()%></h1><br>
        <div class="d-flex justify-content-end">
            <a href = "MainController?action=Create_User_Page" class="btn btn-primary">Create User</a>
            <form name="MainController">
                <input name = "action" type="submit" value="Logout" class="btn btn-primary rounded"/>
            </form>
        </div>

        <div class="text-center">
            <h1>Search: <%= request.getParameter("search")%></h1>
            <form action="MainController" method="GET">
                Search<input type="text" name="search" value="<%= search%>" class="w-25" />
                <input type="submit" name="action" value="Search" />
            </form>

            <%
                List<UserDTO> listUser = (List<UserDTO>) request.getAttribute("LIST_USER");
                if (listUser != null) {
                    if (listUser.size() > 0) {
            %>
            <div class="m-4 shadow">
                <table border="1" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Role ID</th>
                            <th>Password</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int count = 1;
                            for (UserDTO user : listUser) {
                        %>
                    <form action="MainController" method="POST">
                        <tr>
                            <td><%=count++%></td>
                            <td><input type="text" name="userID" value="<%= user.getUserID()%>" readonly="" /></td>
                            <td><input type="text" name="fullName" value="<%= user.getFullName()%>" required="" /></td>
                            <td><input type="text" name="roleID" value="<%= user.getRoleID()%>" required="" /></td>
                            <td><%= user.getPassword()%></td>
                            <!--update-->
                            <td>
                                <input type="submit" name="action" value="Update" class="btn btn-primary"/>
                                <input type="hidden" name="search" value="<%= search%>" />
                            </td>
                            <td>
                                <a href="MainController?action=Delete&userID=<%=user.getUserID()%>&search=<%= search%>" class="btn btn-danger">Delete</a>
                            </td>
                        </tr>
                    </form>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
        <%
                }
            }
        %>      
        <%
            String error = (String) request.getAttribute("NOT_ALLOW");
            if (error == null) {
                out.print("");
            } else {
                out.print(error);
            }


        %>
    </body>
</html>
