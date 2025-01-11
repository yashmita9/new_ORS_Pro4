<%@page import="com.rays.pro4.controller.ProductCtl"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Product</title>
</head>
<body>
	<form action="<%=ORSView.PRODUCT_CTL%>" method="post">
		<%@ include file="Header.jsp"%>
		<jsp:useBean id="bean" class="com.rays.pro4.Bean.ProductBean"
			scope="request"></jsp:useBean>
		<div align="center">
			<h1>Add Product</h1>
			
			<h3><font color="red"><%= ServletUtility.getErrorMessage(request) %></font></h3>
			<h3><font color="green"><%= ServletUtility.getSuccessMessage(request) %></font></h3>
		</div>

		<input type="hidden" name="id" value="<%=bean.getId()%>">

		<div align="center">
			<table>
				<tr>
					<th align="left" style="padding-right: 50px;">Product Name <span
						style="color: red;">*</span> :
					</th>
					<td><input type="text" placeholder="Enter a Product name"
						name="name" value="<%=DataUtility.getStringData(bean.getName())%>"></td>
					<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("name", request)%></font>
				</tr>
				<tr></tr>
				<br>
				<tr>
					<th></th>

					<td><br>
					<input type="submit" name="operation"
						value="<%=ProductCtl.OP_SAVE%>"> <input type="submit"
						name="operation" value="<%=ProductCtl.OP_BACK%>"></td>
				</tr>
			</table>
		</div>
	</form>
	<%@ include file="Footer.jsp"%>
</body>
</html>