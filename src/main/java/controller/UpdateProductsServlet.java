/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.ProductCategoriesDAO;
import dao.ProductsDAO;
import dao.SuppliersDAO;
import dao.WeightUnitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import model.ProductCategories;
import model.Products;
import model.Suppliers;
import model.WeightUnit;

/**
 *
 * @author admin
 */
@WebServlet("/updatePro")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)



public class UpdateProductsServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateProductsServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProductsServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id_raw = request.getParameter("product_id");
        int id;
        ProductsDAO pd = new ProductsDAO();
        ProductCategoriesDAO pcd = new ProductCategoriesDAO();
        SuppliersDAO sd = new SuppliersDAO();
        WeightUnitDAO wud = new WeightUnitDAO();
        
        try{
            id = Integer.parseInt(id_raw);
            Products p = pd.getProductById(id);
            session.setAttribute("product", p);
            
            List<ProductCategories>cate = pcd.getAll();
            session.setAttribute("cate", cate);
            
            List<Suppliers>supp = sd.getAll();
            session.setAttribute("supp", supp);
            
            List<WeightUnit>wu = wud.getAll();
            session.setAttribute("wu", wu);
            
            request.getRequestDispatcher("/view/UpdateProduct.jsp").
                    forward(request, response);  
        }catch(NumberFormatException e){
            System.out.println(e);
        }

    }
    
    
      private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
           String appPath = request.getServletContext().getRealPath("");
//        File projectRoot = new File(appPath).getParentFile().getParentFile();
//        String savePath = projectRoot.getAbsolutePath() + File.separator + "web" + File.separator + "assets" + File.separator + "images" + File.separator + "product";

        String savePath = request.getServletContext().getRealPath("/assets/img/product");
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }

        String fileName = null;
        for (Part part : request.getParts()) {
            if (part.getName().equals("imgPro")) {
                fileName = extractFileName(part);
                if (fileName != null && !fileName.isEmpty()) {
                    part.write(savePath + File.separator + fileName);
                    request.setAttribute("message", savePath + File.separator + fileName);
                }
            }}

            System.out.println("Uploaded file name: " + fileName);

            ProductsDAO pd = new ProductsDAO();
            WeightUnitDAO wud = new WeightUnitDAO();
            ProductCategoriesDAO pcd = new ProductCategoriesDAO();
            SuppliersDAO sd = new SuppliersDAO();
            
            String id_raw = request.getParameter("nameID");
            String name = request.getParameter("namePro");
            String cate_raw = request.getParameter("catePro");
            String supp_raw = request.getParameter("suppPro");
            String unit_raw = request.getParameter("unitPro");
            String price_raw = request.getParameter("pricePro");
            String barcode = request.getParameter("barcode");
            String manufactureDateStr = request.getParameter("ManufactureDate");
            String ExpirationDateStr = request.getParameter("ExpirationDate");
            String batch_raw = request.getParameter("batch");
            
            
            int id = Integer.parseInt(id_raw);
            Products p1 = pd.getProductById(id);
            String img = (fileName != null && !fileName.isEmpty()) ? fileName : p1.getImage();
            
            int cate = Integer.parseInt(cate_raw);
            ProductCategories pc = pcd.getCategoryById(cate);
            
            int supp = Integer.parseInt(supp_raw);
            Suppliers s = sd.getSupById(supp);
            
            int unit = Integer.parseInt(unit_raw);
            WeightUnit wu = wud.getUnitById(unit);
            
            float price = Float.parseFloat(price_raw);
            
            
            
            
            
        
        
    }

    
    
    
    
    
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
