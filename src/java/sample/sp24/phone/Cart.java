/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.sp24.phone;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Admin
 */
public class Cart {

    private Map<String, Phone> cart;

    public Cart() {
    }

    public Cart(Map<String, Phone> cart) {
        this.cart = cart;
    }

    public Map<String, Phone> getCart() {
        return cart;
    }

    public void setCart(Map<String, Phone> cart) {
        this.cart = cart;
    }

    public boolean add(Phone phone) {
        boolean check = false;
        try {
            if (this.cart == null) {
                this.cart = new HashMap<>();
            }
            if (this.cart.containsKey(phone.getId())) {
                int currentQuantity = this.cart.get(phone.getId()).getQuantity();
                phone.setQuantity(currentQuantity + phone.getQuantity());
            }
            this.cart.put(phone.getId(), phone);
            check = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public boolean edit(String id, int quantity) {
        boolean check = false;
        try {
            if(this.cart != null){
                if(this.cart.containsKey(id)){
                    Phone phone = this.cart.get(id);
                    phone.setQuantity(quantity);
                    this.cart.replace(id, phone);
                    check = true;
                }
            }
        } catch (Exception e) {
        }
        
        return check;
    }

    public boolean remove(String id) {
        boolean check = false;
        try {
            if(this.cart != null){
                if(this.cart.containsKey(id)){
                    this.cart.remove(id);
                    check = true;
                }
            }
        } catch (Exception e) {
        }
        
        return check;
    }

}
