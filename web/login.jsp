<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <title> Login page </title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            .mx-10 {
                margin-top: 50px !important;
                margin-left: 200px !important;
                margin-right: 200px !important;
            }
            .bg-gradients{
                background: linear-gradient(to right, #ff7e5f, #feb47b);
            }
        </style>
    </head>
    <body class="bg-gradients">
        <div>
            <h1 class="text-center">Input your Information</h1>
            <div class="border mx-10 p-5 shadow rounded-pill bg-white">
                <div class="d-flex justify-content-center">
                    <form action="MainController" method="POST" id="form">
                        <div class="fw-bold text-center">
                            UserID </br><input type="text" name="userID" /></br>
                            Password</br><input type="password" name="password" /></br>
                        </div>
                        <div class="d-flex justify-content-center">

                            <a class="border m-5 p-3 rounded" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/UserManagementT3S2/google-login&response_type=code
                               &client_id=340957981061-nokomdag5ke2uh05s5u5ngngrnno9ckn.apps.googleusercontent.com&approval_prompt=force"><img src="https://img.icons8.com/color/16/000000/google-logo.png">Login With Google</a>

                        </div>

                        <div class="g-recaptcha mb-5" data-sitekey="6LdaCH8pAAAAACEbCS0Srgd_0YlsBsNPHiR5IuzS"></div>
                        <div class="d-flex justify-content-center">
                            <div class="">
                                <input class="btn btn-primary rounded" type="submit" name="action" value="login"/>
                                <input class="btn btn-primary rounded" type="reset" name="Reset"/>
                                </form> 
                                <div class="pt-1">
                                    <a href="MainController?action=Shopping_Page_View" class="btn btn-primary rounded">Shopping Cart</a>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        </div>
        <%
            String error = (String) request.getAttribute("ERROR");
            if (error == null) {
                error = "";
            }
        %>
        <%= error%>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>

        <script>
            window.onload = function () {
                var form = document.getElementById("form");

                form.addEventListener("submit", function (event) {
                    var response = grecaptcha.getResponse();
                    if (response.length == 0){
                    event.preventDefault();
                            alert("Check da box");
                    } else{
                    console.log(`This is da ${response}`);
                            form.submit();
                    }
                });
            }
        </script>
    </body>
</html>
