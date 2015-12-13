<%-- 
    Document   : StaffHeader
    Created on : Nov 27, 2015, 7:12:46 PM
    Author     : aya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    <%@include file="../MainHead.jsp" %>
    <title>Hostel Management System</title>
    <script>
        
        $(document).ready( function() {
        $('.dropdown-toggle').dropdown();
        }); 
        
    </script>
  </head>

  <body>

    <!-- Fixed navbar -->
    <nav class="navbar-nav navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#main-navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" ><img src="../img/student.png" alt=""></a>
          <a class="navbar-brand" href="studentHome.jsp">Hostel Management System</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
                  <li><a href="ApplyRoom.jsp" class="glyphicon glyphicon-home">  Room</a></li>
          </ul> 
            
              
          <ul class="nav navbar-nav navbar-right">
              <li><a href="../Logout" class="glyphicon glyphicon-log-out"> Logout</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    
  </body>
</html>



