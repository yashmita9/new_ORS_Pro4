package com.rays.pro4.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rays.pro4.Bean.BaseBean;
import com.rays.pro4.Bean.CollegeBean;
import com.rays.pro4.Bean.CustomerBean;
import com.rays.pro4.Exception.ApplicationException;
import com.rays.pro4.Model.CollegeModel;
import com.rays.pro4.Model.CustomerModel;
import com.rays.pro4.Util.DataUtility;
import com.rays.pro4.Util.PropertyReader;
import com.rays.pro4.Util.ServletUtility;

@WebServlet(name = "/CustomerListCtl" , urlPatterns = "/ctl/CustomerListCtl")
public class CustomerListCtl extends BaseCtl{

	@Override
	protected boolean validate(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return super.validate(request);
	}
	
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		CustomerBean bean = new CustomerBean();

	       // bean.setName(DataUtility.getString(request.getParameter("name")));
	        bean.setName(DataUtility.getString(request.getParameter("name")));
	        bean.setLocation(DataUtility.getString(request.getParameter("location")));
	        bean.setImportance(DataUtility.getString(request.getParameter("importance")));
	         return bean;}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 List list = null;
	        
	        List  nextList=null;

	        int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
	        int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

	        pageNo = (pageNo == 0) ? 1 : pageNo;
	        pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;

	       
	        String op = DataUtility.getString(request.getParameter("operation"));
	        
	        String [] ids = request.getParameterValues("ids");
	        CustomerModel model = new CustomerModel();
	        CustomerBean bean = (CustomerBean) populateBean(request);

	                if (OP_SEARCH.equalsIgnoreCase(op)) {
	                    pageNo = 1;
	                } 
	                else if (OP_NEXT.equalsIgnoreCase(op)) {
	                    pageNo++;
	                } 
	                else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
	                    pageNo--;
	                }
	                else if (OP_NEW.equalsIgnoreCase(op)) {
	    			ServletUtility.redirect(ORSView.CUSTOMER_CTL, request, response);
	    			return;
	    		}else if (OP_RESET.equalsIgnoreCase(op)) {
	    			ServletUtility.redirect(ORSView.CUSTOMER_LIST_CTL, request, response);
	    			return;
	    		}  
	            else if (OP_DELETE.equalsIgnoreCase(op)) {
	                pageNo = 1;
	                if (ids != null && ids.length > 0) {
	                   CustomerBean deletebean = new CustomerBean();
	               // 	UserBean deletebean = new UserBean();
	                    for (String id : ids) {
	                        deletebean.setId(DataUtility.getInt(id));
	                        try {
								model.delete(deletebean);
							} catch (ApplicationException e) {
								ServletUtility.handleException(e, request, response);
								return;
							}ServletUtility.setSuccessMessage("Customer Data Successfully Deleted", request);
	                    }
	                } 
	                else {
	                    ServletUtility.setErrorMessage(
	                            "Select at least one record", request);
	                }
	            }
	            try {
					
	            	list = model.search(bean, pageNo, pageSize);
					
	            	nextList=model.search(bean,pageNo+1,pageSize);
					
	            	request.setAttribute("nextlist", nextList.size());
					
				} catch (ApplicationException e) {
					
					ServletUtility.handleException(e, request, response);
					return;
				}
	         //   ServletUtility.setList(list, request);
	            
	            if (list == null || list.size() == 0 && !OP_DELETE.equalsIgnoreCase(op)) {
	                ServletUtility.setErrorMessage("No record found ", request);
	            }
	            ServletUtility.setList(list, request);
	            ServletUtility.setBean(bean, request);
	            ServletUtility.setPageNo(pageNo, request);
	            ServletUtility.setPageSize(pageSize, request);
	            ServletUtility.forward(getView(), request, response);

	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int pageNo = 1;
	        int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));

	        CustomerBean bean = (CustomerBean) populateBean(request);

	        String [] ids = request.getParameterValues("ids");
	        CustomerModel model = new CustomerModel();

	        List list = null;
	        
	        List nextList=null;

	        try {
	            list = model.search(bean, pageNo, pageSize);
	            
	            nextList=model.search(bean,pageNo+1,pageSize);
	            
	            request.setAttribute("nextlist", nextList.size());
	        
	        if (list == null || list.size() == 0) {
	            ServletUtility.setErrorMessage("No record found ", request);
	        }

	        ServletUtility.setList(list, request);
	        ServletUtility.setPageNo(pageNo, request);
	        ServletUtility.setPageSize(pageSize, request);
	        ServletUtility.forward(getView(), request, response);
	    }
	        catch (ApplicationException e) {
	       
	            ServletUtility.handleException(e, request, response);
	            return;
	        }
	}
	
	
	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return ORSView.CUSTOMER_LIST_VIEW;
	}

}
