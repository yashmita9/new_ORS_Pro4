<%@page import="com.rays.pro4.controller.PurchaseCtl"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Bean.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Purchase Order</title>
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
			yearRange : '2023:2024',
		});

	});
</script>

</head>
<body>
	<%@ include file="Header.jsp"%>
	<form action="<%=ORSView.PURCHASE_CTL%>" method="post">
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.PurchaseBean"
		scope="request"></jsp:useBean>
	<%
		List<ProductBean> plist = (List<ProductBean>) request.getAttribute("ProductList");
	%>
	 <div align="center">    
            <h1>
 				
           		<% if(bean != null && bean.getId() > 0) { %>
            <tr><th><font size="5px"> Update Purchase Order </font>  </th></tr>
            	<%}else{%>
			<tr><th><font size="5px"> Add Purchase Order </font>  </th></tr>            
            	<%}%>
            </h1>
   
            <h3><font color="red"> <%=ServletUtility.getErrorMessage(request)%></font>
            <font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font>
            </h3>
	       
</div>
	<input type="hidden" name="id" value="<%=bean.getId()%>">
	<input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
	<input type="hidden" name="modifiedBy"
		value="<%=bean.getModifiedBy()%>">
	<input type="hidden" name="createdDatetime"
		value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
	<input type="hidden" name="modifiedDatetime"
		value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

	<div align="center">
		<table>
			<tr>
				<th align="left">Product Name <span style="color: red">*</span>
					:
				</th>
				<td><%=HTMLUtility.getList("productid", String.valueOf(bean.getProductId()), plist)%>
				</td>
				<td style="position: fixed"><font color="red"><%=ServletUtility.getErrorMessage("productid", request)%></font>
				</td>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>
			<tr>
				<th align="left" style="padding-right: 50px;">Order Date <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" id="udate"
					placeholder="Enter a order Date"
					value="<%=DataUtility.getStringData(bean.getOrderDate())%>"
					readonly="readonly" style="width: 98%" name ="orderDate">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("orderDate", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>

			<tr>
				<th align="left" style="padding-right: 50px;">Quantity <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" placeholder="Enter a Login Id"
					name="quantity"
					value="<%=DataUtility.getStringData(bean.getQuantity())%>"
					style="width: 98%">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("quantity", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>
			<tr>
				<th align="left" style="padding-right: 50px;">Cost <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" placeholder="Enter a cost" name="cost"
					value="<%=DataUtility.getStringData(bean.getCost())%>"
					style="width: 98%">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("cost", request)%></font>
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
                    <input type="submit" name="operation" value="<%=PurchaseCtl.OP_UPDATE%>">
                      &nbsp;  &nbsp;
                    <input type="submit" name="operation" value="<%=PurchaseCtl.OP_CANCEL%>"></td>
                
                <% }else{%>
                
                <td colspan="2" > 
                &nbsp;  &emsp;
                    <input type="submit" name="operation" value="<%=PurchaseCtl.OP_SAVE%>">
                    &nbsp;  &nbsp;
                    <input type="submit" name="operation" value="<%=PurchaseCtl.OP_RESET%>"></td>
                
                <% } %>
                </tr>


		</table>
		<br> <a href="<%=ORSView.PRODUCT_CTL%>"> Add New Product Name</a>


	</div>
	</form>
	<%@ include file="Footer.jsp"%>
</body>
</html>