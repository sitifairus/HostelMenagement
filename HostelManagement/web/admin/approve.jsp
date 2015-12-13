<%-- 
    Document   : approve
    Created on : Dec 11, 2015, 5:35:04 PM
    Author     : on
--%>

<%@page import="database.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        String UserSession = (String)session.getAttribute("userID");
        if(UserSession==null)
        {
            response.sendRedirect("../index.html");
        }
        DB db = new DB();
        if(db.connect())
        {
    %>
    <body>
        <h1>List Of Request Room</h1>
        
        <table border="1">
            <tr>
                <td>student ID</td>
                <td>Student Name</td>
                <td>College Request</td>
                <td>Room Type Request</td>
                <td>Status</td>
                <td colspan="2">Option</td>
            </tr>
            <%
                if(db.query("SELECT * FROM request INNER JOIN userdata ON request.studentID=userdata.id INNER JOIN kolej ON request.kolejReqID=kolej.kolejID"))
                {
                    for(int i=0; i< db.getNumberOfRows();i++)
                    {
                        
            %>
            <tr>
                <td><%=db.getDataAt(i,"studentID")%></td>
                <td><%=db.getDataAt(i,"fullName")%></td>
                <td><%=db.getDataAt(i,"kolejName")%></td>
                <td><%
                if(db.getDataAt(i, "roomType").equals("1"))
                    out.println("Single");
                else
                    out.println("Double");
                %></td>
                <td><%=db.getDataAt(i,"status")%></td>
                <td>
                    <form method="get" action="../Approve">
                        <input type="hidden" name="requestID" value="<%=db.getDataAt(i,"requestID")%>">
                        <input type="submit" value="Approve" class="btn bg-success">
                    </form>
                </td>
                <td>
                    <form method="get" action="#">
                        <input type="hidden" name="requestID" value="<%=db.getDataAt(i,"requestID")%>">
                        <input type="submit" value="Not Approve" class="btn bg-success">
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
        
    </body>
    <%
            db.close();
        }
        else
            response.sendRedirect("../index.html");
    
    %>
</html>
