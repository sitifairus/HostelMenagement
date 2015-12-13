/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sevlet;

import database.DB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author on
 */
@WebServlet(name = "LoginVerification", urlPatterns = {"/LoginVerification"})
public class LoginVerification extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String username=request.getParameter("username");
            String password=request.getParameter("password");
            
            DB db= new DB();
            //System.out.println("password:");
            if(db.connect())
            {
                db.query("select * from userData where username='"+username+"' and password='"+password+"' ");
                if(db.getNumberOfRows()!=0)
                {
                    System.out.println("connected. usename="+username);
                    int userType=Integer.parseInt(db.getDataAt(0,"userType"));
                    String userID=db.getDataAt(0, "id");
                    HttpSession session = request.getSession(true);
                    session.setAttribute("userID", userID);
                    if(userType==0)
                    {
                        
                        System.out.println("Go to admin Page!");
                        response.sendRedirect("admin/AdminHome.jsp");
                    }
                    else if(userType==1)
                    {
                        System.out.println("Go to student Page!");
                        response.sendRedirect("student/studentHome.jsp");
                    }
                    else
                    {
                        System.out.println("user type cannot identify!");
                        response.sendRedirect("index.html");
                    }
                    
                }
                else
                {
                    System.out.println("username or password incorrect!!");
                    response.sendRedirect("index.html");
                }
                
                db.close();
            }
            else
            {
                System.out.println("not connecteed!!");
                response.sendRedirect("index.html");
            }
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
