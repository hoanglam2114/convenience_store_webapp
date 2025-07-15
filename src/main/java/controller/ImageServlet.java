package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

/**
 * @author hoang on 7/15/2025-7:54 PM
 * IntelliJ IDEA
 */
@WebServlet(name = ("ImageServlet"),urlPatterns = {"/uploads/*"})
public class ImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = request.getPathInfo().substring(1); // ví dụ: avatars/peji.png hoặc products/sp1.png
        File file = new File("uploads", path);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mime = getServletContext().getMimeType(file.getName());
        response.setContentType(mime != null ? mime : "application/octet-stream");

        Files.copy(file.toPath(), response.getOutputStream());
    }
}
