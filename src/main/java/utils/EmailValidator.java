/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author nguye
 */
public class EmailValidator {
    // Regular expression để kiểm tra định dạng email
    private static final String EMAIL_REGEX =
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
    
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile(EMAIL_REGEX);
    
    
    public static boolean isValidEmail(String email) {
        // Kiểm tra null hoặc chuỗi rỗng
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        // Kiểm tra định dạng email bằng regex
        Matcher matcher = EMAIL_PATTERN.matcher(email);
        return matcher.matches();
    }
}
