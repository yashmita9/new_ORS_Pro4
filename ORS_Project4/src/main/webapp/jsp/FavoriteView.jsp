<%@page import="com.rays.pro4.controller.FavoriteCtl"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Bean.FavoriteBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Favorite List</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		$("#udate").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : '2023:2025',
		});

	});
</script>

</head>
<body>
<%@ include file="Header.jsp"%>
	<form action="<%=ORSView.FAVORITE_CTL%>" method="post">
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.FavoriteBean"
		scope="request"></jsp:useBean>
	<%
		List<FavoriteBean> plist = (List<FavoriteBean>) request.getAttribute("favoriteList");
	%>
	 <div align="center">    
            <h1>
 				
           		<% if(bean != null && bean.getId() > 0) { %>
            <tr><th><font size="5px"> Update Favorite List </font>  </th></tr>
            	<%}else{%>
			<tr><th><font size="5px"> Add Favorite List </font>  </th></tr>            
            	<%}%>
            </h1>
   
            <h3><font color="red"> <%=ServletUtility.getErrorMessage(request)%></font>
            <font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font>
            </h3>
	       
</div>
	<input type="hidden" name="id" value="<%=bean.getId()%>">
	<div align="center">
		<table>
			<tr>
				<th align="left" style="padding-right: 50px;">Product <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" placeholder="Enter a Product "
					name="product"
					value="<%=DataUtility.getStringData(bean.getProduct())%>"
					style="width: 98%">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("product", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>
			<tr>
				<th align="left" style="padding-right: 50px;">Added Date <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" id="udate"
					placeholder="Enter a Added Date"
					value="<%=DataUtility.getStringData(bean.getAddedDate())%>"
					readonly="readonly" style="width: 98%" name ="addedDate">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("addedDate", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>

			<tr>
				<th align="left" style="padding-right: 50px;">Customer Name <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" placeholder="Enter a Customer Name"
					name="customerName"
					value="<%=DataUtility.getStringData(bean.getCustomerName())%>"
					style="width: 98%">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("customerName", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>
			<tr>
				<th align="left" style="padding-right: 50px;">Comments <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" placeholder="Enter a Comments" name="comments"
					value="<%=DataUtility.getStringData(bean.getComments())%>"
					style="width: 98%">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("comments", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>

			<tr ><th></th>
                <%
                if(bean.getId()>0){
                %>
                <td colspan="2" >
                &nbsp;  &emsp;
                    <input type="submit" name="operation" value="<%=FavoriteCtl.OP_UPDATE%>">
                      &nbsp;  &nbsp;
                    <input type="submit" name="operation" value="<%=FavoriteCtl.OP_CANCEL%>"></td>
                
                <% }else{%>
                
                <td colspan="2" > 
                &nbsp;  &emsp;
                    <input type="submit" name="operation" value="<%=FavoriteCtl.OP_SAVE%>">
                    &nbsp;  &nbsp;
                    <input type="submit" name="operation" value="<%=FavoriteCtl.OP_RESET%>"></td>
                
                <% } %>
                </tr>


		</table>
		

	</div>
	</form>
	<%@ include file="Footer.jsp"%>

</body>
</html>