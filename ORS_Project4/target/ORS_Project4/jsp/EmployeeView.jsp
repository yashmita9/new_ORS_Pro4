<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee page</title>
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
			yearRange : '1980:2020',
		});

	});
</script>
</head>
<body>
	<%@ include file="Header.jsp"%>
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.EmployeeBean"
		scope="request"></jsp:useBean>
	<div align="center">
		<h1>Add Employee</h1>
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
				<th align="left" style="padding-right: 50px;">First Name <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" placeholder="Enter a first name"
					name="firstName"
					value="<%=DataUtility.getStringData(bean.getFirstName())%>">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("firstName", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>

			<tr>
				<th align="left" style="padding-right: 50px;">Last Name <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" placeholder="Enter a Last Name"
					name="lastName"
					value="<%=DataUtility.getStringData(bean.getLastName())%>">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("lastName", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>
			<tr>
				<th align="left" style="padding-right: 50px;">Login Id <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" placeholder="Enter a Login Id"
					name="loginId"
					value="<%=DataUtility.getStringData(bean.getLoginId())%>">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("loginId", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>
			<tr>
				<th align="left" style="padding-right: 50px;">Password <span
					style="color: red;">*</span> :
				</th>
				<td><input type="password" placeholder="Enter a Password"
					name="password"
					value="<%=DataUtility.getStringData(bean.getPassword())%>">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("password", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>
			<tr>
				<th align="left" style="padding-right: 50px;">Birth Date <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" id="udate"
					placeholder="Enter a Birth Date" name="dob"
					value="<%=DataUtility.getStringData(bean.getDob())%>"
					readonly="readonly">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("dob", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>
			<tr>
				<th align="left" style="padding-right: 50px;">Contact Number <span
					style="color: red;">*</span> :
				</th>
				<td><input type="text" placeholder="Enter a Contact Number"
					name="contactNo"
					value="<%=DataUtility.getStringData(bean.getContactNo())%>">
				<td style="position: fixed;"><font color="red"><%=ServletUtility.getErrorMessage("contactNo", request)%></font>
			</tr>
			<tr>
				<th style="padding: 3px"></th>
			</tr>
			<tr>
				<th></th>
			</tr>
		</table>


	</div>
	<%@ include file="Footer.jsp"%>
</body>
</html>