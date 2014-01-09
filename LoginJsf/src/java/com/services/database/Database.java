/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.services.database;

import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ashwith
 */
public class Database {

  
    
    public static Connection getConnection() throws ClassNotFoundException{
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
      Connection   con = DriverManager.getConnection("jdbc:mysql://localhost:3306/testjsf","root","ash");
         return con;
        } catch (SQLException ex) {
            System.out.println("Database.getConnection() Error -->" + ex.getMessage());
            return null;
        }
    }
       public static void close(Connection con) {
        try {
            con.close();
        } catch (Exception ex) {
        }
    }
        
    
}
