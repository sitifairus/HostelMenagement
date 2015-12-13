<%-- 
    Document   : studentHome
    Created on : Dec 12, 2015, 11:52:27 AM
    Author     : on
--%>

<%@page import="database.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

  <%@include file="../MainHead.jsp" %>
  <title>Hostel Management System</title>
  
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
        <%@include file="StuHeader.jsp" %>
        <br><br><br><br><br>
        <h1>Student home</h1>
    </body>
    <%
        }
    
    %>
</html>
