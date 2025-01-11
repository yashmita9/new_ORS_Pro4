package com.rays.proj4.Test;

import java.sql.Timestamp;
import java.util.Date;

import com.rays.pro4.Bean.CollegeBean;
import com.rays.pro4.Bean.PurchaseBean;
import com.rays.pro4.Exception.ApplicationException;
import com.rays.pro4.Exception.DuplicateRecordException;
import com.rays.pro4.Model.CollegeModel;
import com.rays.pro4.Model.PurchaseModel;

public class PurchaseModelTest {

	public static void main(String[] args) throws DuplicateRecordException {

		 testAdd();
		// testDelete();
		// searchFindByName();
		// searchFindByPk();
		// update();
		// search();
//		list();

	}
	private static void testAdd() throws DuplicateRecordException {
		try {
		PurchaseBean bean = new PurchaseBean();
			// bean.setId(2L);
			bean.setProductId(2);
			bean.setQuantity(5);
			bean.setOrderDate(new Date());
			bean.setCost(20000);
			bean.setCreatedBy("Admin");
			bean.setModifiedBy("Admin");
			bean.setCreatedDatetime(new Timestamp(new Date().getTime()));
			bean.setModifiedDatetime(new Timestamp(new Date().getTime()));
			PurchaseModel model = new PurchaseModel();
			long pk = model.add(bean);
			System.out.println("Test Add succ");
			PurchaseBean addedBean = model.findByPK(pk);
			if (addedBean == null) {
				System.out.println("Test ass fail");
			}
		} catch (ApplicationException e) {
			e.printStackTrace();
		}
	}
	
}
