<%-- 
    Document   : ApplyRoom.jsp
    Created on : Nov 27, 2015, 7:09:21 PM
    Author     : aya
--%>

<%@page import="database.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
       
    <!-- Container -->
      <div class="container">
        <div class="row">
            
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >
           <div class="col-md-12 col-lg-20">
            
             
           </div>
            <br><br><br>
            <%
                if(db.query("SELECT * FROM request INNER JOIN kolej ON request.kolejReqID=kolej.kolejID WHERE studentID='"+UserSession+"'"))
                {
                    if(db.getNumberOfRows()!=0)
                    {
                        
            %>
                You Have request room As follow:
                <table>
                    <tr>
                        <td>Kolej</td>
                        <td>:</td>
                        <td><%=db.getDataAt(0,"kolejName")%></td>
                    </tr>
                    <tr>
                        <td>Room Type</td>
                        <td>:</td>
                        <td>
                            <%
                            if(db.getDataAt(0, "roomType").equals("1"))
                                out.println("Single");
                            else
                                out.println("Double");
                        %></td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td>:</td>
                        <td><%=db.getDataAt(0,"status")%></td>
                    </tr>
                </table>
                    
        </div>
      </div>
    </div>
            <%
                    }
                    else
                    {
                        db.query("SELECT * FROM room INNER JOIN block ON block.blockID=room.blockID INNER JOIN kolej ON block.kolejID=kolej.kolejID WHERE studentID='"+UserSession+"'");
                        if(db.getNumberOfRows()==0) 
                        {
            %>
            <form method="get" action="../ApplyRoom">
          <div class="panel panel-info">
            <div class="panel-heading">
              <h3 class="panel-title">Apply Room</h3>
            </div>
            <div class="panel-body">
              <div class="row">
                <div align="center">
                  <table cellpadding="6" cellspacing="5" width="50%">
                    <tbody>
                      <tr>
                        <td>
                            <label>Kolej        </label>
                        </td>
                        <td>:
                             <select name="kolejID" >
                                 <%
                                    if(db.query("SELECT * FROM kolej"))
                                    {
                                        for(int i=0; i<db.getNumberOfRows();i++)
                                        {
                                            
                                 %>
                                <option value="<%=db.getDataAt(i,"kolejID")%>"><%=db.getDataAt(i,"kolejName")%></option>
                                <%
                                        }
                                    }
                                    else
                                    {
                                        
                                    }
                                %>
                            </select>
                        </td>
                      </tr>
                      <tr>
                        <td>
                            <label>Room Type</label>
                        </td>
                        <td> :
                             <select  name="rt">
                                <option value="1">Single</option>
                                <option value="2">Double</option>
                            </select>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                  
                </div>
              </div>
            </div>
                <div class="panel-footer" align="center">
                    <input type="hidden" name="userID" value="<%=UserSession%>">
                    <input type="submit" value="Apply" class="btn bg-primary">
                </div>
            
          </div>
            </form>
            <%
                        }
                        else
                        {  
            %>
                <div class="container">
        <div class="row">
            
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >
           
            <br><br><br>
         
          <div class="panel panel-info">
            <div class="panel-heading">
              <h3 class="panel-title">Room Details</h3>
            </div>
            <div class="panel-body">
              <div class="row">
                <div align="center">
                  <table cellpadding="6" cellspacing="5" width="50%">
                     <tr>
                         <td>College</td>
                         <td>: <%=db.getDataAt(0, "kolejName")%></td>
                     </tr> 
                     <tr>
                         <td>Block</td>
                         <td>: <%=db.getDataAt(0, "blockName")%></td>
                     </tr> 
                     <tr>
                         <td>Room Number</td>
                         <td>: <%=db.getDataAt(0, "roomNo")%></td>
                     </tr>
                     <tr>
                         <td>Room Type</td>
                         <td>: <% if(db.getDataAt(0, "roomType").equals("1"))
                                    out.println("Single");
                                  else
                                    out.println("Double");
                         %></td>
                     </tr>
                      <tr>
                         <td>Status</td>
                         <td>: Approve</td>
                     </tr> 
                 </table>
                </div>  
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
            <%
                        }
                    }
                }
            %>
    </body>
    <%
            db.close();
        }
        else
            response.sendRedirect("../index.html");
    
    %>
</html>




