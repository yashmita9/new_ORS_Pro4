<%@page import="com.rays.pro4.controller.CustomerCtl"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
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
<form action="CustomerCtl" method="POST">
		<%@ include file="Header.jsp"%>

		<jsp:useBean id="bean" class="com.rays.pro4.Bean.CustomerBean" scope="request"></jsp:useBean>

		<div align="center">
			<h1 align="center" style="margin-bottom: -15; color: navy">
				<%
					if (bean != null && bean.getId() > 0) {
				%>Update<%
					} else {
				%>Add<%
					}
				%>
				Customer
			</h1>

			<div style="height: 15px; margin-bottom: 12px">
				<H3 align="center">
					<font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
					</font>
				</H3>
				<H3 align="center">
					<font color="red"> <%=ServletUtility.getErrorMessage(request)%>
					</font>
				</H3>
			</div>
			<input type="hidden" name="id" value="<%=bean.getId()%>"> 
			<table>
				<tr>
					<th align="left">Name<span style="color: red">*</span></th>
					<td><input type="text" name="name" placeholder="Enter Customer Name"
						value="<%=DataUtility.getStringData(bean.getName())%>" style="width: 97%"></td>
					<td style="position: fixed;"><font color="red"> <%=ServletUtility.getErrorMessage("name", request)%></font></td>
				</tr>
				<tr>
					<th align="left">Location<span style="color: red">*</span></th>
					<td><input type="text" name="location" placeholder="Enter Location"
						value="<%=DataUtility.getStringData(bean.getLocation())%>" style="width: 97%"></td>
					<td style="position: fixed;"><font color="red"> <%=ServletUtility.getErrorMessage("location", request)%></font></td>
				</tr>
				<tr>
					<th align="left">Contact Number<span style="color: red">*</span></th>
					<td><input type="text" name="contactNo" placeholder="Enter Contact number"
						value="<%=DataUtility.getStringData(bean.getContactNo())%>" style="width: 97%"></td>
					<td style="position: fixed;"><font color="red"> <%=ServletUtility.getErrorMessage("contactNo", request)%></font></td>
				</tr>
				<tr>
				<th align="left">Importance<span style="color: red">*</span></th>
				<td><% HashMap map = new HashMap();
				map.put("High", "High");
				map.put("Meddium", "Meddium");
				map.put("Low", "Low");
				
				String htmlList = HTMLUtility.getList("importance", bean.getImportance(), map);
				%>
				<%=htmlList %></td>
				 <td style="position: fixed" ><font color="red"> <%=ServletUtility.getErrorMessage("importance", request)%></font></td>
                 
				</tr>
				<tr>
					<th></th>
					<td></td>
				</tr>
				<tr>
					<th></th>
					<%
						if (bean != null && bean.getId() > 0) {
					%>
					<td align="left" colspan="2"><input type="submit"
						name="operation" value="<%=CustomerCtl.OP_UPDATE%>"> <input
						type="submit" name="operation" value="<%=CustomerCtl.OP_CANCEL%>">
						<%
							} else {
						%>
					<td align="left" colspan="2"><input type="submit"
						name="operation" value="<%=CustomerCtl.OP_SAVE%>"> <input
						type="submit" name="operation" value="<%=CustomerCtl.OP_RESET%>">
						<%
							}
						%>
				</tr>
			</table>
		</div>
	</form>

	<%@ include file="Footer.jsp"%>
</body>
</html>