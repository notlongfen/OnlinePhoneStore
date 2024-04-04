/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.sp24.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.sp24.order.ProductDAO;
import sample.sp24.order.ProductDTO;
import sample.sp24.phone.Cart;
import sample.sp24.phone.Phone;
import sample.sp24.user.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String SUCCESS = "checkout.jsp";
    private static final String ERROR = "checkout.jsp";
    private static final String LOGGEDIN = "login.jsp";
    private static final String QUANTITY_ERROR = "viewCart.jsp";
    private static final String ADMIN_CANNOT_BUY = "login.jsp"; 

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            boolean check = false;
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                url = LOGGEDIN;
                request.getRequestDispatcher(url).forward(request, response);
            }
            if("AD".equals(loginUser.getRoleID())){
                url = ADMIN_CANNOT_BUY;
                session.setAttribute("ERROR", "Admin is not allowed to use shopping page");
                request.getRequestDispatcher(url).forward(request, response);
            }

            ArrayList<ProductDTO> list = new ArrayList<>();
            ArrayList<Integer> lowQuantity = new ArrayList<>();
            ProductDAO p = new ProductDAO();
//            double total = Double.parseDouble((String) session.getAttribute("TOTAL"));
            double total = 0.0;
            for (Phone phone : cart.getCart().values()) {
                total += phone.getQuantity() * phone.getPrice();
            }
            boolean detailInserted = true;

            String orderID = p.insertOrder(loginUser.getUserID(), total);
            for (Phone phone : cart.getCart().values()) {
                detailInserted &= p.insertOrderDetail(orderID, phone.getId(), total, phone.getQuantity());
                list.add(new ProductDTO(orderID, phone.getId(), total, phone.getQuantity()));
                int tmp = p.DbGetQuantity(phone.getId());
                
                if (tmp < phone.getQuantity()) {
                    lowQuantity.add(tmp);
                }
            }

            if (detailInserted) {
                url = SUCCESS;
                check = true;
                session.setAttribute("ORDERED", check);
                session.setAttribute("LIST_ORDERED", list);
            } else {
                int rows = p.deleteOrdersRowThatAreNotLinked();
                if (rows != 0) {
//                    for(int i = 0; i< cart.getCart().size(); i++){
                    session.setAttribute("ALERT", "Some product is low on quantity ");
                    session.setAttribute("LOWQUANTITY", lowQuantity);
                    
                    url = QUANTITY_ERROR;
//                    }
                }
            }

        } catch (Exception e) {
            log("Error at Checkout" + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }

        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
