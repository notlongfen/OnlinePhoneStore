/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sample.sp24.user;

/**
 *
 * @author nguye
 */
public class UserDTO {
    private String fullName;
    private String roleID;
    private String password;
    private String userID;

    public UserDTO() {
        this.fullName = "";
        this.roleID = "";
        this.password = "";
        this.userID = "";
    }

    public UserDTO(String fullName, String userID) {
        this.fullName = fullName;
        this.userID = userID;
    }
    
    

    public UserDTO(String userID, String fullName, String roleID, String password) {
        this.fullName = fullName;
        this.roleID = roleID;
        this.password = password;
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }
    
    
}
