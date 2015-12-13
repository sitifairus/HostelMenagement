<%-- 
    Document   : block
    Created on : Dec 11, 2015, 5:34:51 PM
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
        <h1>BLOCK / COLLEGE</h1>
        
        <h3>create new College</h3>
        <form method="get" action="../createKolej">
        College Name :
            <input type="text" placeholder="Enter College Name" name="kolejName">
            <br><br>
            
            <input type="submit" value="creat College">
        </form>
        
        <h3>create new block</h3>
        
        <form method="get" action="../addBlock">
            College Name : 
            <select name="kolejID">
                <%db.query("SELECT * FROM kolej");
                    for(int i=0; i<db.getNumberOfRows(); i++)
                    {
                     
                %>
                <option value="<%=db.getDataAt(i,"kolejID")%>"><%=db.getDataAt(i,"kolejName")%></option>
                <%
                    }
                %>
            </select><br><br>
            Block Name :
            <input type="text" placeholder="Enter Block Name" name="blockName">
            <br><br>
            
            <input type="submit" value="creat Block">
        </form>
        
        <h3>insert room</h3>
        <form method="get" action="../addRoom">
            Block Name : 
            <select name="blockID">
                <%db.query("SELECT * FROM block INNER JOIN kolej ON block.kolejID=kolej.kolejID");
                    for(int i=0; i<db.getNumberOfRows(); i++)
                    {
                     
                %>
                <option value="<%=db.getDataAt(i,"blockID")%>"><%=db.getDataAt(i,"blockName")%>, <%=db.getDataAt(i,"kolejName")%></option>
                <%
                    }
                %>
            </select><br><br>
            Room Number :
            <input type="text" placeholder="Enter Room Number" name="roomNo">
            <br><br>
            Room Type :
            <select name="roomType">
                <option value="1">Single</option>
                <option value="2">Double</option>
            </select>
            
            <br><br>
            <input type="submit" value="add room">
        </form>
        
            <br><br>
            <h3>list of Room</h3>
        <table border="1">
            <tr>
                <td>Room ID</td>
                <td>College Name</td>
                <td>Block Name</td>    
                <td>Room Number</td>
                <td>student</td>
                <td>Room Type</td>
                <td colspan="2">Option</td>
            </tr>
            <%
                if(db.query("SELECT * FROM room INNER JOIN block ON room.blockID=block.blockID INNER JOIN kolej ON block.kolejID=kolej.kolejID"))
                {
                    if(db.getNumberOfRows()!=0)
                    {
                        for(int i =0; i<db.getNumberOfRows();i++)
                        {
            %>
            <tr>
                <td><%=db.getDataAt(i, "roomID")%></td>
                <td><%=db.getDataAt(i, "kolejName")%></td>
                <td><%=db.getDataAt(i, "blockName")%></td>  
                <td><%=db.getDataAt(i, "roomNo")%></td> 
                <td><%
                    if(db.getDataAt(i, "studentID").equals("0"))
                        out.println("No Student");
                    else
                    {
                        out.println(db.getDataAt(i, "studentID"));
                    }
                        
                %></td>
                <td><%
                        if(db.getDataAt(i, "roomType").equals("1"))
                            out.println("Single");
                        else if(db.getDataAt(i, "roomType").equals("2"))
                            out.println("Double");
                        else
                            out.println("type not stated");
                %></td> 
                <td><button >Edit</button></td>
                <td><button >Delete</button></td>
            </tr>
            <%
                        }
                    }
                }
                else
                    out.println("table not found");
            %>
        </table>
    </body>
    <%
            db.close();
        }
        else
            response.sendRedirect("index.html");
    
    %>
</html>
