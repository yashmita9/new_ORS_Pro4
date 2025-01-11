<%@page import="com.rays.pro4.Bean.PurchaseBean"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.rays.pro4.controller.PurchaseListCtl"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.controller.ORSView"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Purchase Order List</title>
<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/Checkbox11.js"></script>

</head>
<body>
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.PurchaseBean"
		scope="request"></jsp:useBean>
	<%@include file="Header.jsp"%>


	<form action="<%=ORSView.PURCHASE_LIST_CTL%>" method="post">

		<div align="center">
			<h1>Purchase Order List</h1>
			<h3>
				<font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
				<font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>
			</h3>

		</div>

		<%
			int pageNo = ServletUtility.getPageNo(request);
			int pageSize = ServletUtility.getPageSize(request);
			int index = ((pageNo - 1) * pageSize) + 1;

			int next = DataUtility.getInt(request.getAttribute("nextlist").toString());
			List list = ServletUtility.getList(request);
			Iterator<PurchaseBean> it = list.iterator();

			if (list.size() != 0) {
		%>

		<br>

		<table border="1" width="100%" align="center" cellpadding=6px
			cellspacing=".2">
			<tr style="background: skyblue">
				<th><input type="checkbox" id="select_all" name="select">Select
					All</th>

				<th>S.No.</th>
				<th>Product Name</th>
				<th>Order Date</th>
				<th>Quantity</th>
				<th>Cost</th>
				<th>Edit</th>
			</tr>

			<%
				while (it.hasNext()) {
						bean = it.next();
			%>


			<tr align="center">
				<td><input type="checkbox" class="checkbox" name="ids"
					value="<%=bean.getId()%>"></td>
				<td><%=index++%></td>
				<td><%=bean.getProductName()%></td>
				<td><%=bean.getOrderDate()%></td>

				<td><%=bean.getQuantity()%></td>
				<td><%=bean.getCost()%></td>
				<td><a href="PurchaseCtl?id=<%=bean.getId()%>">Edit</a></td>
			</tr>
			<%
				}
			%>
		</table>

		<table width="100%">
			<tr>
				<th></th>
				<%
					if (pageNo == 1) {
				%>
				<td><input type="submit" name="operation" disabled="disabled"
					value="<%=PurchaseListCtl.OP_PREVIOUS%>"></td>
				<%
					} else {
				%>
				<td><input type="submit" name="operation"
					value="<%=PurchaseListCtl.OP_PREVIOUS%>"></td>
				<%
					}
				%>

				<td><input type="submit" name="operation"
					value="<%=PurchaseListCtl.OP_DELETE%>"></td>
				<td><input type="submit" name="operation"
					value="<%=PurchaseListCtl.OP_NEW%>"></td>


				<td align="right"><input type="submit" name="operation"
					value="<%=PurchaseListCtl.OP_NEXT%>"
					<%=(list.size() < pageSize || next == 0) ? "disabled" : ""%>></td>



			</tr>
		</table>
		<%
			}
			if (list.size() == 0) {
		%>
		<td align="center"><input type="submit" name="operation"
			value="<%=PurchaseListCtl.OP_BACK%>"></td>
		<%
			}
		%>

		<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
			type="hidden" name="pageSize" value="<%=pageSize%>">
	</form>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>




	</form>
	<%@include file="Footer.jsp"%>
</body>
</html>