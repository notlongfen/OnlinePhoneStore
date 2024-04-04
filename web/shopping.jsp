<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <title>Store Cua Tao</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript">window.$crisp = [];
            window.CRISP_WEBSITE_ID = "a04aba06-967a-464d-9a7a-bb2b70ac4457";
            (function () {
                d = document;
                s = d.createElement("script");
                s.src = "https://client.crisp.chat/l.js";
                s.async = 1;
                d.getElementsByTagName("head")[0].appendChild(s);
            })();
        </script>
    </head>
    <body>
        <h1 class="text-center"> Choose your wanted item</h1>
        <form action="MainController" method="POST">
            <div class="dropdown-center d-flex justify-content-center">
                <select name="phone"> 
                    <option value="P001-Iphone 15-27000" class="dropdown-item">Iphone 15-27.000$</option>
                    <option value="P002-Iphone 15 Pro-30000" class="dropdown-item">Iphone 15 Pro-30.000$</option>
                    <option value="P003-Iphone 15 Promax-32000" class="dropdown-item">Iphone 15 Pro Max-32.000$</option>
                    <option value="P004-Tai Nghe-5000" class="dropdown-item">Tai Nghe 5000$</option>
                    <option value="P005-Ipad-5000" class="dropdown-item">Ipad 5000</option>
                    <option value="P006-AppleWatch zen 9-3000" class="dropdown-item">AppleWatch zen 9-3000$</option>
                </select>
                <div class="fw-bold m-2">Quantity: </div> 
                <div class="m-2">
                    <select name="quantity">

                        <option value="1" class="dropdown-item">1</option>
                        <option value="2" class="dropdown-item">2</option>
                        <option value="3" class="dropdown-item">3</option>
                        <option value="4" class="dropdown-item">4</option>
                        <option value="5" class="dropdown-item">5</option>
                        <option value="10" class="dropdown-item">10</option>

                    </select>
                </div>
                <div>
                    <input type="submit" name="action" value="Add" class="btn btn-primary rounded"/>
                    <input type="submit" name="action" value="View" class="btn btn-primary rounded"/>

                    <form name="MainController">
                        <input name = "action" type="submit" value="Logout" class="btn btn-primary rounded"/>
                    </form>
                </div>
            </div>

        </form>
        <%
            String message = (String) request.getAttribute("MESSAGE");
            if(message ==null) message = "";
        %>
        <div class="fw-bold text-center"><%= message%></div>
        
        
        <div class="d-flex justify-content-center">
        <script type="text/javascript">(function () {
                d = document;
                s = d.createElement("script");
                s.src = "https://widget.supportai.com/98ad551e551511b.js";
                s.async = 1;
                d.getElementsByTagName("head")[0].appendChild(s);
            })();</script>
        </div>
    </body>
</html>
