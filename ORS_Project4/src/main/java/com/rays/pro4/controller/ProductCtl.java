package com.rays.pro4.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rays.pro4.Bean.BaseBean;
import com.rays.pro4.Bean.ProductBean;
import com.rays.pro4.Exception.ApplicationException;
import com.rays.pro4.Exception.DuplicateRecordException;
import com.rays.pro4.Model.ProductModel;
import com.rays.pro4.Util.DataUtility;
import com.rays.pro4.Util.ServletUtility;


@WebServlet(name = "/ProductCtl" , urlPatterns = "/ctl/ProductCtl")
public class ProductCtl extends BaseCtl{

	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		ProductBean bean = new ProductBean();
		
		bean.setId(DataUtility.getLong(request.getParameter("id")));
		bean.setName(DataUtility.getStringData(request.getParameter("name")));
		return bean;
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletUtility.forward(getView(), request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String op = DataUtility.getStringData(request.getParameter("operation"));
		ProductModel model = new ProductModel();
		
		if((OP_SAVE).equalsIgnoreCase(op)) {
			ProductBean bean = (ProductBean) populateBean(request);
			try {
				model.add(bean);
				
				ServletUtility.setSuccessMessage("Product Added Successfully.....!!!", request);
			} catch (ApplicationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (DuplicateRecordException e) {
				ServletUtility.setErrorMessage("Product Name is already exist...!!!!", request);
			}
			ServletUtility.forward(getView(), request, response);
		}else if(OP_BACK.equalsIgnoreCase(op)) {
			ServletUtility.redirect(ORSView.PURCHASE_CTL, request, response);
		}
	}
	
	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return ORSView.PRODUCT_VIEW;
	}

}
