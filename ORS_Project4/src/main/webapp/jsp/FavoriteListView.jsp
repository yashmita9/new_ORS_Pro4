<%@page import="com.rays.pro4.controller.FavoriteListCtl"%>
<%@page import="com.rays.pro4.Bean.FavoriteBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="bean" class="com.rays.pro4.Bean.FavoriteBean" scope="request" ></jsp:useBean>
    <%@include file="Header.jsp"%>


  <form action="<%=ORSView.FAVORITE_LIST_CTL%>" method="POST">
    
    <center>
    
     <div align="center">
	        <h1>Favorite List</h1>
            <h3><font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
            <font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></h3>
     </div>
     
     <% 
	             
     int next=DataUtility.getInt(request.getAttribute("nextlist").toString());

	    		%>
	     
       <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<FavoriteBean> it = list.iterator();

	       			if(list.size() !=0){
                    %>
            
            <table width="80%" align="center">
                <tr>
                 <td align="center">
                 	<label>Product :</label> 
    	             <input type="text" name="product" placeholder="Enter product" Size= "25" value="<%=ServletUtility.getParameter("product", request)%>">
                    &nbsp;
                    
<!--                    <label> Importance</label> -->
<%-- 				<% HashMap map = new HashMap(); --%>
<!-- // 				map.put("High", "High"); -->
<!-- // 				map.put("Meddium", "Meddium"); -->
<!-- // 				map.put("Low", "Low"); -->
				
<!-- // 				String htmlList = HTMLUtility.getList("importance", bean.getImportance(), map); -->
<%-- 				%> --%>
<%-- 				<%=htmlList %>     --%>


        	         <input type="submit" name="operation" value="<%=FavoriteListCtl.OP_SEARCH%>">
        	         &nbsp;
        	         <input type="submit" name="operation" value="<%=FavoriteListCtl.OP_RESET%>">
        	         
                 </td>
                </tr>
            </table>
            
            <br>
            
            <table border="1" width="100%" align="center" cellpadding=6px cellspacing=".2">
                 <tr style="background: skyblue">
                <th><input type="checkbox" id="select_all" name="select">Select All.</th>
                
                <th>S.No.</th>
                <th>Product.</th>
                <th>Added Date.</th>
                <th>Customer Name.</th>
                <th>Comments.</th>
                <th>Edit</th>
                </tr>
                
                <%
                	while(it.hasNext())
                	{
                		 bean = it.next();
                %>
                
                
                
       <tr align="center">
           	<td><input type="checkbox" class="checkbox" name="ids" value="<%=bean.getId() %>">
                    <td><%=index++%></td>
                    <td><%=bean.getProduct()%></td>
                    <td><%=bean.getAddedDate()%></td>
                    <td><%=bean.getCustomerName()%></td>
                    <td><%=bean.getComments()%></td>
                    
                    <td><a href="FavoriteCtl?id=<%=bean.getId()%>">Edit</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <table width="100%">
                <tr>
                <%if(pageNo == 1){ %>
                    <td><input type="submit" name="operation" disabled="disabled" value="<%=FavoriteListCtl.OP_PREVIOUS%>">
       				<%}else{ %>
       				<td><input type="submit" name="operation"  value="<%=FavoriteListCtl.OP_PREVIOUS%>"></td>
       				<%} %>		
                     
                     <td><input type="submit" name="operation" value="<%=FavoriteListCtl.OP_DELETE%>"> </td>
                    <td> <input type="submit" name="operation" value="<%=FavoriteListCtl.OP_NEW%>"></td>
                    
                     
                    <td align="right"><input type="submit"  name="operation" value="<%=FavoriteListCtl.OP_NEXT%>" <%=(list.size()<pageSize||next==0)?"disabled":"" %>> </td>
			
                    
                </tr>
            </table>
            		<%}if(list.size() == 0){ %>
            		<td align="center"><input type="submit" name="operation" value="<%=FavoriteListCtl.OP_BACK%>"></td>	
            		<% } %>
            	
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> 
            <input type="hidden" name="pageSize" value="<%=pageSize%>">
        </form>
                 </br>
                 </br>
                 </br>
                   </br>
                   </br>
                   </br>
    </center>

 <%@include file="Footer.jsp"%>

</body>
</html>