package com.team1.admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.team1.admin.dto.ApplicantDTO;
import com.team1.admin.dto.InquiryDTO;
import com.team1.admin.dto.PageDTO;
import com.team1.admin.dto.RealAttendanceListDTO;
import com.team1.model.HanbitDB;

public class SalesDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public SalesDAO() {
		// TODO Auto-generated constructor stub
	}
	
	private void closeAll() throws SQLException {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
	
	public void hit_count(int idx,int hit) throws ClassNotFoundException, SQLException{
		String sql = "update inquiry_bbs set hit =? where idx = ?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hit);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public int countall() {
		String sql = "select count(*) from inquiry_bbs";
		int allcount =0;
		try {
			conn = HanbitDB.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				allcount = rs.getInt(1);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return allcount;
	}
	
	public PageDTO page_detail(int page, int countall) {
		PageDTO bean2 = new PageDTO();
		
		final int ROWSIZE = 10;
		final int BLOCK = 5;
	
		int pg = page;
		int allPage = countall/ROWSIZE;
		if(countall%ROWSIZE>0) allPage++;
	
		int startPage = ((pg-1)/BLOCK*BLOCK)+1;
		int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;
		if(allPage<endPage) endPage = allPage;
			
		bean2.setAllpage(allPage);
		bean2.setBlock(BLOCK);
		bean2.setEndPage(endPage);
		bean2.setPg(pg);
		bean2.setRowSize(ROWSIZE);
		bean2.setStartPage(startPage);
		return bean2;
	}
	
	public void inquiry_succ(int idx) throws SQLException, ClassNotFoundException {
		String sql = "update inquiry_bbs set flag=? where idx=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 1);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public void inquiry_del(int idx) throws SQLException, ClassNotFoundException {
		String sql = "delete from inquiry_bbs where idx=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public InquiryDTO inquiry_detail(int idx) throws ClassNotFoundException, SQLException{
		InquiryDTO bean = new InquiryDTO();
		String sql = "select * from inquiry_bbs where idx=?";
		try{
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				bean.setIdx(rs.getInt("idx"));
				bean.setName(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
				bean.setPhone(rs.getString("phone"));
				bean.setFlag(rs.getInt("flag"));
				bean.setMemo(rs.getString("memo"));
				bean.setCurdate(rs.getDate("curdate").toString());
				bean.setCurtime(rs.getTime("curtime").toString());
				bean.setHit(rs.getInt("hit"));
			}
		}finally{
			closeAll();
		}
		return bean;
	}
	
	public ArrayList<InquiryDTO> inquiry_list(int page) throws SQLException, ClassNotFoundException {
		ArrayList<InquiryDTO> list = new ArrayList<InquiryDTO>();
		String sql="select idx, name, title, phone, flag, curdate, curtime, hit from inquiry_bbs order by idx desc limit ?, 10";
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page*10-10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				InquiryDTO bean = new InquiryDTO();
				bean.setIdx(rs.getInt("idx"));
				bean.setName(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
				bean.setPhone(rs.getString("phone"));
				bean.setFlag(rs.getInt("flag"));
				bean.setCurdate(rs.getDate("curdate").toString());
				bean.setCurtime(rs.getTime("curtime").toString());
				bean.setHit(rs.getInt("hit"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	
	
	public void insertAttinfo(String id, ArrayList<RealAttendanceListDTO> list) throws ClassNotFoundException, SQLException {
		String sql = "insert into attend(curdate, stu_id, class_code) values (?, ?, ?)";
		
		try {
			conn = HanbitDB.getConnection();
			
			for(int i=0; i<list.size(); i++) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, list.get(i).getCurdate());
				pstmt.setString(2, id);
				pstmt.setString(3, list.get(i).getClass_code());
				pstmt.executeUpdate();
			}
		} finally {
			closeAll();
		}
	}
	
	public ArrayList<RealAttendanceListDTO> getAttInfo(String class_code) throws ClassNotFoundException, SQLException {
		ArrayList<RealAttendanceListDTO> list = new ArrayList<RealAttendanceListDTO>();
		String sql = "select curdate, curmonth from attend_info where class_code=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				RealAttendanceListDTO bean = new RealAttendanceListDTO();
				bean.setClass_code(class_code);
				bean.setCurdate(rs.getDate("curdate").toString());
				bean.setCurmonth(rs.getInt("curmonth"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public int insertStudentJob(String id, String name) throws ClassNotFoundException, SQLException {
		String sql = "insert into student_job values(?, ?, 0)";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int updateClassCurNum(String class_code) throws ClassNotFoundException, SQLException {
		String sql = "update class set cur_stunum=cur_stunum+1 where code=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int approveApplicant(String id) throws ClassNotFoundException, SQLException {
		String sql = "update student set approve=? where id=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 1);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public ApplicantDTO getApplicantDetailInfo(String id) throws ClassNotFoundException, SQLException {
		ApplicantDTO bean = new ApplicantDTO();
		String sql = "select * from student as stu, class where stu.class_code=class.code and stu.id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setId(rs.getString("stu.id"));
				bean.setName(rs.getString("stu.name"));
				bean.setAddress(rs.getString("stu.address"));
				bean.setBirthday(rs.getDate("stu.birthday").toString());
				bean.setGender(rs.getString("stu.gender"));
				bean.setClass_code(rs.getString("stu.class_code"));
				bean.setMail(rs.getString("stu.mail"));
				bean.setPw(rs.getString("stu.pw"));
				bean.setClass_title(rs.getString("class.title"));
				bean.setStart_date(rs.getDate("class.start_date").toString());
				bean.setEnd_date(rs.getDate("class.end_date").toString());
				bean.setTeacher(rs.getString("class.teacher_name"));
				bean.setPhone(rs.getString("stu.phone"));
				bean.setCur_stunum(rs.getInt("class.cur_stunum"));
				bean.setLimit_num(rs.getInt("class.limit_num"));
			}
		} finally {
			closeAll();
		}
		return bean;
	}
	
	public ArrayList<ApplicantDTO> getApplicantInfo() throws ClassNotFoundException, SQLException {
		ArrayList<ApplicantDTO> list = new ArrayList<ApplicantDTO>();
		String sql = "select * from student as stu, class where stu.class_code=class.code and stu.approve=0";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ApplicantDTO bean = new ApplicantDTO();
				bean.setId(rs.getString("stu.id"));
				bean.setName(rs.getString("stu.name"));
				bean.setAddress(rs.getString("stu.address"));
				bean.setBirthday(rs.getDate("stu.birthday").toString());
				bean.setGender(rs.getString("stu.gender"));
				bean.setClass_code(rs.getString("stu.class_code"));
				bean.setMail(rs.getString("stu.mail"));
				bean.setPw(rs.getString("stu.pw"));
				bean.setClass_title(rs.getString("class.title"));
				bean.setStart_date(rs.getDate("class.start_date").toString());
				bean.setEnd_date(rs.getDate("class.end_date").toString());
				bean.setTeacher(rs.getString("class.teacher_name"));
				bean.setPhone(rs.getString("stu.phone"));
				bean.setCur_stunum(rs.getInt("class.cur_stunum"));
				bean.setLimit_num(rs.getInt("class.limit_num"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
}
