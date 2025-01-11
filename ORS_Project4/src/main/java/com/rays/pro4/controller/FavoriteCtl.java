package com.rays.pro4.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rays.pro4.Bean.BaseBean;
import com.rays.pro4.Bean.CustomerBean;
import com.rays.pro4.Bean.FavoriteBean;
import com.rays.pro4.Exception.ApplicationException;
import com.rays.pro4.Exception.DuplicateRecordException;
import com.rays.pro4.Model.CustomerModel;
import com.rays.pro4.Model.FavoriteModel;
import com.rays.pro4.Util.DataUtility;
import com.rays.pro4.Util.DataValidator;
import com.rays.pro4.Util.PropertyReader;
import com.rays.pro4.Util.ServletUtility;

@WebServlet(name = "/FavoriteCtl" , urlPatterns = "/ctl/FavoriteCtl")
public class FavoriteCtl extends BaseCtl{


	/** The log. */
	private static Logger log = Logger.getLogger(CollegeCtl.class);
	
	@Override
	protected boolean validate(HttpServletRequest request) {
		log.debug("CustomerCtl Method validate Started");
		boolean pass = true;

		if (DataValidator.isNull(request.getParameter("product"))) {
			request.setAttribute("product", PropertyReader.getValue("error.require", "Product"));
			pass = false;
		}else if (!DataValidator.isName(request.getParameter("product"))) {
			request.setAttribute("product", "product contains alphabet only");
			pass = false;
		}
		if (DataValidator.isNull(request.getParameter("customerName"))) {
			request.setAttribute("customerName", PropertyReader.getValue("error.require", "Customer Name"));
			pass = false;
		}else if (!DataValidator.isName(request.getParameter("customerName"))) {
			request.setAttribute("customerName", "Customer Name contains alphabet only");
			pass = false;
		}

		if (DataValidator.isNull(request.getParameter("comments"))) {
			request.setAttribute("comments", PropertyReader.getValue("error.require", "Comments"));
			pass = false;
		}
		
		if (DataValidator.isNull(request.getParameter("addedDate"))) {
			request.setAttribute("addedDate", PropertyReader.getValue("error.date", "Date"));
			pass = false;
		}

		log.debug("Favorite Ctl Method validate Ended");
		return pass;
}
	
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("Favorite Ctl Method populatebean Started");
		FavoriteBean bean = new FavoriteBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));
		bean.setProduct(DataUtility.getString(request.getParameter("product")));
		bean.setAddedDate(DataUtility.getDate(request.getParameter("addedDate")));
		bean.setCustomerName(DataUtility.getString(request.getParameter("customerName")));
		bean.setComments(DataUtility.getString(request.getParameter("comments")));
		return bean;
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("FavoriteCtl Method doPost Started");
		String op = DataUtility.getString(request.getParameter("operation"));
		long id = DataUtility.getLong(request.getParameter("id"));
		
		FavoriteModel model = new FavoriteModel();
		if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {
			FavoriteBean bean = (FavoriteBean) populateBean(request);
			try {
				if (id > 0) {
					model.update(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("Favorite List is successfully Updated ", request);
			
				} else {
					long pk = model.add(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("Favorite List is successfully Added ", request);
			
			//		bean.setId(pk);
				}
				ServletUtility.setBean(bean, request);
				} catch (ApplicationException e) {
				e.printStackTrace();
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			} catch (DuplicateRecordException e) {
				}
		} 
		else if ( OP_RESET.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.FAVORITE_CTL, request, response);
			return;
		}		else if (OP_CANCEL.equalsIgnoreCase(op) ) {

			ServletUtility.redirect(ORSView.FAVORITE_LIST_CTL, request, response);
			return;
		}
		
		ServletUtility.forward(getView(), request, response);
		
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String op = DataUtility.getString(request.getParameter("operation"));
		long id = DataUtility.getLong(request.getParameter("id"));
		
		FavoriteModel model = new FavoriteModel();
		
		if (id > 0) {
			FavoriteBean bean;
			try {
				bean = model.findByPK(id);
				ServletUtility.setBean(bean, request);
			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			}
		}
		ServletUtility.forward(getView(), request, response);
	
		
	}
	
	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return ORSView.FAVORITE_VIEW;
	}

	
}
