<%-- 
    Document   : AdminHome
    Created on : Dec 11, 2015, 5:09:19 PM
    Author     : on
--%>

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
    
    %>
    <body>
        <h1>ADMIN PAGE</h1>
        userID : <%=UserSession%>
        <a href="block.jsp">Block</a>
        <a href="approve.jsp">Approve</a>
    </body>
</html>
