package com.rays.pro4.Bean;

import java.util.Date;

public class PurchaseBean extends BaseBean{
	
	private long quantity;
	private long productId;
	private String productName;
	private Date orderDate;
	private double cost;

	
	
	public long getProductId() {
		return productId;
	}

	public void setProductId(long productId) {
		this.productId = productId;
	}

	public long getQuantity() {
		return quantity;
	}

	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public double getCost() {
		return cost;
	}

	public void setCost(double cost) {
		this.cost = cost;
	}

	@Override
	public String getkey() {
		
		return id+"";
	}

	@Override
	public String getValue() {

		return productName;
	}

}
