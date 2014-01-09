
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.services.database.Database;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Ashwith
 */
class UserDAO {
    public static boolean validate(String username,String password) throws SQLException
    {Connection con = null;
        PreparedStatement ps = null;
        try {
            con = (Connection) Database.getConnection();
            ps = (PreparedStatement) con.prepareStatement(
                    "select username,password from userinfo where username=? and password=?");
            ps.setString(1, username);
            ps.setString(2, password);
  
            ResultSet rs = ps.executeQuery();
            if (rs.next()) // found
            {
                System.out.println(rs.getString("username"));
                return true;
            }
            else {
                return false;
            }
        } catch (Exception ex) {
            System.out.println("Error in login() -->" + ex.getMessage());
            return false;
        } finally {
            Database.close(con);
        }
    }
}
