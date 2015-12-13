/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sevlet;

import database.DB;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author on
 */
@WebServlet(name = "Approve", urlPatterns = {"/Approve"})
public class Approve extends HttpServlet {

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
            String requestID=request.getParameter("requestID");
             DB db = new DB();
            if(db.connect())
            {
                if(db.query("SELECT * FROM request WHERE requestID='"+requestID+"'"))
                {
                    String kolejID=db.getDataAt(0, "kolejReqID");
                    String studentID=db.getDataAt(0, "studentID");
                    String roomType=db.getDataAt(0,"roomType");
                    db.query("SELECT * FROM block WHERE kolejID='"+kolejID+"'");
                    ArrayList blockID=new ArrayList();
                    for(int i=0; i<db.getNumberOfRows(); i++)
                    {
                        blockID.add(db.getDataAt(i, "blockID"));
                    }
                    for(int k=0; k<blockID.size(); k++)
                    {
                        if(db.query("SELECT * FROM room WHERE blockID='"+blockID.get(k)+"' AND roomType='"+roomType+"' AND studentID='0'"))
                        {
                            String roomID=db.getDataAt(0, "roomID");
                            if(roomID!=null)
                            {
                                if(db.query("UPDATE room SET studentID='"+studentID+"' WHERE roomID='"+roomID+"'"))
                                {
                                    System.out.println(roomID);
                                    System.out.println("Approve");
                                    db.query("DELETE FROM request WHERE requestID='"+requestID+"'");
                                    break;
                                }
                            }
                            else
                                System.out.println("Not found requested room!");
                            
                        }
                        else
                                System.out.println("Not found requested room!");
                    }
                    
                }
                
                db.close();
                response.sendRedirect("admin/block.jsp");
                
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
