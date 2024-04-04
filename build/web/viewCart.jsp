<%@page import="java.util.ArrayList"%>
<%@page import="sample.sp24.phone.Phone"%>
<%@page import="sample.sp24.phone.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String error = (String) session.getAttribute("ALERT");
            ArrayList<Integer> listError = (ArrayList<Integer>) session.getAttribute("LOWQUANTITY");

            if (error == null) {
                error = "";
                System.out.println("No error");
            } else {
                System.out.println(listError);

            }

        %>
        <h1 class="text-center"> Here are your chosen products </h1>
        <%            Cart cart = (Cart) session.getAttribute("CART");
            if (cart != null) {
                if (cart.getCart().size() > 0) {

        %>
        <table border="1" class="table table-hover table-striped">
            <thead>
                <tr>
                    <th>No</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Edit</th>
                    <th>Remove</th>


                </tr>
            </thead>
            <tbody>
                <%int count = 1;
                    double total = 0;
                    int i = 0, j = 0, k = 0;
                    for (Phone phone : cart.getCart().values()) {
                        total += phone.getQuantity() * phone.getPrice();
                        i++;
                %>

            <form action="MainController" method="POST">
                <tr>
                    <td><%= count++%></td>
                    <td>
                        <input type="text" name="id" value="<%= phone.getId()%>" readonly=""/> 
                    </td>
                    <td><%= phone.getName()%></td>
                    <td><%= phone.getPrice()%></td>
                    <td>
                        <input type="text" name="quantity" value="<%= phone.getQuantity()%>" required="" /> 
                    </td>
                    <td><%= phone.getQuantity() * phone.getPrice()%></td>
                    <%
                        if (listError != null && !listError.isEmpty() && k != i) {
                            while (j < i && j < listError.size()) {
                    %>
                    <td><%= error + String.valueOf(listError.get(j))%></td>
                    <%          j++;
                                k++;
                        } k++;    %>

                    <% } else { %>
                    <td class="text-success">Instock</td>
                    <%    }%>
                    <td>
                        <input type="submit" name="action" value="Edit" class="btn btn-primary"/>
                    </td>
                    <td>
                        <input type="submit" name="action" value="Remove" class="btn btn-danger"/>
                    </td>
                </tr>
            </form>

            <%       }
                session.setAttribute("TOTAL", total);%>
        </tbody>
    </table>
    <h1 class="text-center"> Total: <%= total%></h1> 
    <form action = "MainController" method="POST">
        <div class="d-flex justify-content-end p-4">
            <input type="submit" name="action" value="Checkout" class="btn btn-primary "/>
        </div>
    </form>
    <%     }
        }
    %>
    <a href="shopping.html" class="btn btn-primary">Add more</a>
    <div class = "d-flex justify-content-center">
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
            Want To Recieve Our News? Or Having Question ?
        </button>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="SendMailServlet" method="post">
                            <label for="toEmail">To Email:</label>
                            <input type="email" id="toEmail" name="toEmail" required><br>

                            <label for="subject">Subject:</label>
                            <input type="text" id="subject" name="subject" required><br>

                            <label for="message">Message:</label>
                            <textarea id="message" name="message" rows="4" cols="50" required></textarea><br>

<!--                            <input type="submit" value="Send Email">-->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" value="Send Email">Send Email</button>
                    </div>
                        </form>
                </div>
            </div>
        </div>
    </div>
    
    <%
    String received = (String) session.getAttribute("MAIL");
    String clicked = (String) session.getAttribute("CLICKED");
    if(received != null){ %>
    <div class="text-success text-center fs-2"><%= received %> </div>
    <%}else if("true".equals(clicked) && received ==null){%>
    <div class="text-danger text-center">Please try again</div>
    <%}
    %>
</body>
</html>