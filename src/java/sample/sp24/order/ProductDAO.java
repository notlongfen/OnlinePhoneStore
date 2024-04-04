/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.sp24.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.concurrent.atomic.AtomicLong;
import sample.sp24.ultis.DBUltis;

/**
 *
 * @author Admin
 */
public class ProductDAO {

    private static final String SEARCH_USERID = "Select * From tblUsers WHERE userID = ?";
    private static final String SEARCH_ORDERID = "Select * From Orders WHERE orderID = ?";
    private static final String SEARCH_PRODUCTID = "Select * From Product WHERE productID = ?";
    private static final String SEARCH_QUANTITY = "Select quantity From Product WHERE productID = ?";
    private static final String SEARCH_PRODUCT_DETAIL_ID = "Select * From OrderDetail WHERE productID = ?";
    private static final String INSERT_ORDER = "INSERT INTO Orders (orderID, userID, orderDate, total)VALUES (?, ?, GETDATE(), ?)";
    private static final String INSERT_ORDER_DETAIL = "Insert Into OrderDetail(orderID, productID, price, quantity) Values(?, ?, ?, ?)";
    private static final String INSERT_PRODUCT = "";
    private static final String UPDATE_QUANTITY = "UPDATE Product SET quantity = quantity - ? WHERE productID = ?";

    private static final String DELETE_ORDERS_THAT_ARE_NOT_LINKED_TO_ORDER_DETAIL = "DELETE O\n" +
"FROM Orders O\n" +
"LEFT JOIN OrderDetail OD ON O.orderID = OD.orderID\n" +
"WHERE OD.orderID IS NULL;";

    private static final AtomicLong sequence = new AtomicLong(System.currentTimeMillis() / 1000);

    public static String getNext() {
        return Long.toString(sequence.incrementAndGet());
    }

    public String insertOrder(String userID, double total) throws SQLException {
        boolean check = false;
        String orderID = getNext();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUltis.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_USERID);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    ptm.clearParameters();
                    ptm = conn.prepareStatement(INSERT_ORDER);
                    ptm.setString(1, orderID);
                    ptm.setString(2, userID);
                    ptm.setDouble(3, total);
                    int rows = ptm.executeUpdate();
                    if (rows != 0) {
                        check = true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return orderID;
    }

    public boolean insertOrderDetail(String orderID, String productID, double price, int quantity) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        String pid = productID;
        try {
            conn = DBUltis.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ORDERID);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                ptm.clearParameters();

                ptm = conn.prepareStatement(SEARCH_PRODUCTID);
                ptm.setString(1, productID);
                rs1 = ptm.executeQuery();
                ptm.clearParameters();

                if (rs.next() && rs1.next()) {
                    ptm = conn.prepareStatement(SEARCH_QUANTITY);
                    ptm.setString(1, productID);
                    rs2 = ptm.executeQuery();
                    int dbQuantity = 0;
                    if (rs2.next()) {
                        dbQuantity = rs2.getInt("quantity");
                    }
                    if (dbQuantity < quantity) {
                        return false;
                    } else {
                        ptm.clearParameters();
                        ptm = conn.prepareStatement(INSERT_ORDER_DETAIL);
                        ptm.setString(1, orderID);
                        ptm.setString(2, productID);
                        ptm.setDouble(3, price);
                        ptm.setInt(4, quantity);
                        int rows = ptm.executeUpdate();
                        ptm.clearParameters();

                        if (rows != 0) {
                            ptm = conn.prepareStatement(UPDATE_QUANTITY);
                            ptm.setInt(1, quantity);
                            ptm.setString(2, productID);
                            ptm.executeUpdate();
                            check = true;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
            if (rs != null) {
                rs1.close();
            }
        }
        return check;
    }

    public int deleteOrdersRowThatAreNotLinked() throws SQLException {
        int rows = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUltis.getConnection();
            ptm = conn.prepareStatement(DELETE_ORDERS_THAT_ARE_NOT_LINKED_TO_ORDER_DETAIL);
            rows = ptm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return rows;
    }
    
    public int DbGetQuantity(String productID) throws SQLException{
        int quantity = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        
        try {
            conn = DBUltis.getConnection();
            ptm = conn.prepareStatement(SEARCH_QUANTITY);
            ptm.setString(1, productID);
            rs = ptm.executeQuery();
            if(rs.next()){
            quantity = rs.getInt("quantity");
            }else{
                throw new SQLException("No quantity found for productID: " + productID);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return quantity;
    }
}
