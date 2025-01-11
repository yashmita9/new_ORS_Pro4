package com.rays.pro4.Model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.rays.pro4.Bean.FavoriteBean;
import com.rays.pro4.Exception.ApplicationException;
import com.rays.pro4.Exception.DatabaseException;
import com.rays.pro4.Exception.DuplicateRecordException;
import com.rays.pro4.Util.JDBCDataSource;

public class FavoriteModel {

	private static Logger log = Logger.getLogger(FavoriteModel.class);

	public Integer nextPK() throws DatabaseException {
		log.debug("Modal nextPK Started");
		Connection conn = null;
		int pk = 0;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(ID) FROM favorite_list");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				pk = rs.getInt(1);
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception", e);
			throw new DatabaseException("Exceptio :Exception in getting PK");

		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model nextPK End");
		return pk + 1;
	}
	public long add(FavoriteBean bean) throws ApplicationException,DuplicateRecordException{
		log.debug("Model add Started");
		Connection conn=null;
		int pk=0;
		
		try{
			conn=JDBCDataSource.getConnection();
			pk=nextPK();
			conn.setAutoCommit(false);
			PreparedStatement pstmt=conn.prepareStatement("INSERT INTO favorite_list VALUES(?,?,?,?,?)");
			pstmt.setInt(1, pk);
			pstmt.setString(2, bean.getProduct());
			pstmt.setDate(3, new java.sql.Date(bean.getAddedDate().getTime()));
			pstmt.setString(4, bean.getCustomerName());
			pstmt.setString(5, bean.getComments());
			pstmt.executeUpdate();
			conn.commit();
			pstmt.close();
		}catch(Exception e){
			log.error("Database Exception",e);
			try{
				conn.rollback();
			}catch(Exception ex){
				ex.printStackTrace();
				throw new ApplicationException("Exception : add rollback exception"+ex.getMessage());
			}
			throw new ApplicationException("Exception : Exception in add Favorite");
		}finally{
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model add End");
		return pk;
	}

	public void delete(FavoriteBean bean) throws ApplicationException {
		log.debug("Model delete Started");
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			conn.setAutoCommit(false);
			PreparedStatement pstmt = conn.prepareStatement("DELETE FROM favorite_list WHERE ID=?");
			pstmt.setLong(1, bean.getId());
			pstmt.executeUpdate();
			conn.commit();
			pstmt.close();
		} catch (Exception e) {
			log.error("Database Exception ", e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				throw new ApplicationException("Exception :Delete rollback exception" + ex.getMessage());
			}
			throw new ApplicationException("Exception : Exception in delete Favorite");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Modal delete End");
	}

	public FavoriteBean findByName(String name) throws ApplicationException {
		log.debug("Model findByName Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM favorite_list WHERE product=?");
		FavoriteBean bean = null;
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, name);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new FavoriteBean();
				bean.setId(rs.getLong(1));
				bean.setProduct(rs.getString(2));
				bean.setAddedDate(rs.getDate(3));
				bean.setCustomerName(rs.getString(4));
				bean.setComments(rs.getString(5));
				
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception", e);
			throw new ApplicationException("Exception : Exception in getting Favorite List byName");

		} finally {
			JDBCDataSource.closeConnection(conn);

		}
		log.debug("modal findByName End");
		return bean;
	}

	public FavoriteBean findByPK(long pk) throws ApplicationException {
		log.debug("Model Find BY Pk Stsrted");
		StringBuffer sql = new StringBuffer("SELECT*FROM favorite_list WHERE id=?");
		FavoriteBean bean = null;
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setLong(1, pk);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new FavoriteBean();
				bean.setId(rs.getLong(1));
				bean.setProduct(rs.getString(2));
				bean.setAddedDate(rs.getDate(3));
				bean.setCustomerName(rs.getString(4));
				bean.setComments(rs.getString(5));
				}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception ", e);
			throw new ApplicationException("Exception : Exception is getting Favorite List byPK");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Find By PK End");
		return bean;
	}

	public void update(FavoriteBean bean) throws ApplicationException, DuplicateRecordException {
		log.debug("Model update Started");
		Connection conn = null;

		try {

			conn = JDBCDataSource.getConnection();

			conn.setAutoCommit(false); // Begin transaction
			String sql = "UPDATE favorite_list SET product=?,added_date=?,customer_name=?,comments=? WHERE ID=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bean.getProduct());
			pstmt.setDate(2, new java.sql.Date(bean.getAddedDate().getTime()));
			pstmt.setString(3, bean.getCustomerName());
			pstmt.setString(4, bean.getComments());
			pstmt.setLong(5, bean.getId());
			pstmt.executeUpdate();
			System.out.println("update ..................");
			conn.commit(); // End transaction
			pstmt.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				throw new ApplicationException("Exception : update rollback exception " + ex.getMessage());
			}
			// throw new ApplicationException("Exception in updating College ");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model update End");
	}

	public List search(FavoriteBean bean) throws ApplicationException {
		return search(bean, 0, 0);
	}

	public List search(FavoriteBean bean, int pageNo, int PageSize) throws ApplicationException {
		log.debug("model search Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM favorite_list WHERE 1=1");

		if (bean != null) {
			if (bean.getId() > 0) {
				sql.append(" AND id = " + bean.getId());
			}
			if (bean.getProduct() != null && bean.getProduct().length() > 0) {
				sql.append(" AND product like '" + bean.getProduct() + "%'");
			}
			
		}
		System.out.println(sql);
		// if page size is greater than zero then apply pagination
		if (PageSize > 0) {
			// Calculate start record index
			pageNo = (pageNo - 1) * PageSize;
			sql.append(" Limit " + pageNo + "," + PageSize);

		}
		ArrayList list = new ArrayList();

		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new FavoriteBean();

				bean.setId(rs.getLong(1));
				bean.setProduct(rs.getString(2));
				bean.setAddedDate(rs.getDate(3));
				bean.setCustomerName(rs.getString(4));
				bean.setComments(rs.getString(5));
				list.add(bean);
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in search Favorite list");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("model search End");
		return list;
	}

	public List list() throws ApplicationException {
		return list(0, 0);
	}

	public List list(int pageNo, int pageSize) throws ApplicationException {
		log.debug("Model list Started");
		ArrayList list = new ArrayList();
		StringBuffer sql = new StringBuffer("select * from favorite_list");
		// if page size is greater than zero then apply pagination
		if (pageSize > 0) {
			// Calculate start record index
			pageNo = (pageNo - 1) * pageSize;
			sql.append(" limit " + pageNo + "," + pageSize);
		}

		Connection conn = null;
		FavoriteBean bean = null;

		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new FavoriteBean();
				bean.setId(rs.getLong(1));
				bean.setProduct(rs.getString(2));
				bean.setAddedDate(rs.getDate(3));
				bean.setCustomerName(rs.getString(4));
				bean.setComments(rs.getString(5));
				list.add(bean);
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting list of users");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}

		log.debug("Model list End");
		return list;

	}
	
}
