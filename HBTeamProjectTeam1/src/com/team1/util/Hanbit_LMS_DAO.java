package com.team1.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.team1.model.HanbitDB;

public class Hanbit_LMS_DAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public Hanbit_LMS_DAO() {
	
	}
	
	private void closeAll() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	} 
	
	public String searchPW(String table, String id, String name, String phone) throws ClassNotFoundException, SQLException {
		String sql = "select pw from " + table + " where id=? and name=? and phone=?";
		String pw = "";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pw = rs.getString("pw");
			}
		} finally {
			closeAll();
		}
		return pw;
	}
	
	public String searchID(String table, String name, String phone) throws ClassNotFoundException, SQLException {
		String sql = "select id from " + table + " where name=? and phone=?";
		String id = "";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString("id");
			}
		} finally {
			closeAll();
		}
		return id;
	}
	
	public int insertInquiry(String title, String name, String phone, String memo) throws ClassNotFoundException, SQLException {
		String sql = "insert into inquiry_bbs (title, name, phone, memo, hit, curdate, curtime) values(?, ?, ?, ?, ?,current_date(), current_time())";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, name);
			pstmt.setString(3, phone);
			pstmt.setString(4, memo);
			pstmt.setInt(5, 0);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public boolean idcheck(String id) throws ClassNotFoundException, SQLException {
		String sql ="select count(*) as cnt from student where id=?";
		int cnt=0;
		boolean tf=false;
		try {
			System.out.println("test2");
			conn=HanbitDB.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()){
				cnt=rs.getInt("cnt");
				if(cnt==0) tf=true;
			}
		} finally {
			closeAll();
		}
		return tf;
	}
	
	public int insertStudent(String id, String pw, String name, String gender, String subTitle, String address, String email, String birth, String phone) throws ClassNotFoundException, SQLException {
		String sql = "insert into student values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		int result = 0;
		try {
			conn = HanbitDB.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, gender);
			pstmt.setString(5, address);
			pstmt.setString(6, email);
			pstmt.setString(7, birth);
			pstmt.setInt(8, 0);
			pstmt.setString(9, phone);
			pstmt.setString(10, subTitle);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public ArrayList<HanbitClassNoticeDTO> getClassNoticeInfo(String class_code) throws ClassNotFoundException, SQLException {
		ArrayList<HanbitClassNoticeDTO> list = new ArrayList<HanbitClassNoticeDTO>();
		String sql = "select idx, title, name, curdate, curtime from classnotice_bbs where class_code=? order by idx desc limit 8";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				HanbitClassNoticeDTO bean = new HanbitClassNoticeDTO();
				bean.setIdx(rs.getInt("idx"));
				bean.setTitle(rs.getString("title"));
				bean.setName(rs.getString("name"));
				bean.setCurdate(rs.getDate("curdate").toString());
				bean.setCurtime(rs.getTime("curtime").toString());
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public ArrayList<HanbitNoticeDTO> getNoticeInfo() throws ClassNotFoundException, SQLException {
		ArrayList<HanbitNoticeDTO> list = new ArrayList<HanbitNoticeDTO>();
		String sql = "select idx, title, name, curdate, curtime from notice_bbs order by idx desc limit 8";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				HanbitNoticeDTO bean = new HanbitNoticeDTO();
				bean.setIdx(rs.getInt("idx"));
				bean.setTitle(rs.getString("title"));
				bean.setName(rs.getString("name"));
				bean.setCurdate(rs.getDate("curdate").toString());
				bean.setCurtime(rs.getTime("curtime").toString());
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public int updateUserInfo(String table, String id, String pw, String name, String birthday, String mail, String address, String phone) throws ClassNotFoundException, SQLException {
		int result = 0;
		String sql = "update " + table + " set pw=?, name=?, birthday=?, mail=?, address=?, phone=? where id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setString(2, name);
			pstmt.setString(3, birthday);
			pstmt.setString(4, mail);
			pstmt.setString(5, address);
			pstmt.setString(6, phone);
			pstmt.setString(7, id);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public HanbitUserInfoDTO getUserinfo(String id, String table) throws ClassNotFoundException, SQLException {
		HanbitUserInfoDTO bean = new HanbitUserInfoDTO();
		String sql = "select pw, name, gender, address, mail, birthday, phone from ";
		sql += table + " where id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setId(id);
				bean.setPw(rs.getString("pw"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setAddress(rs.getString("address"));
				bean.setMail(rs.getString("mail"));
				bean.setBirthday(rs.getDate("birthday").toString());
				bean.setPhone(rs.getString("phone"));
			}
		} finally {
			closeAll();
		}
		return bean;
	}
	
	public String getClassCode(int hb_code, String id) throws ClassNotFoundException, SQLException {
		String class_code = null;
		String sql = null;
		if(hb_code==1) sql = "select class_code from student where id=?";
		else sql = "select class_code from teacher where id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				class_code = rs.getString("class_code");
			}
		} finally {
			closeAll();
		}
		return class_code;
	}
	
	public int login(String id, String pw, String user_code) throws SQLException, ClassNotFoundException {
		
		String sql = null;
		int hb_code = 0;
		
		if(user_code.equals("학생")) {
			sql = "select pw from student where id=? and approve=1";
			hb_code = 1;
		}
		else if(user_code.equals("직원")) {
			sql = "select pw, staff_code from employee where id=?";
		}
		else return hb_code;
			
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			if(user_code.equals("학생")) {
				rs = pstmt.executeQuery();
				
				// 일치하는 id 있을경우
				if(rs.next()) {
					String rs_pw = rs.getString("pw");
					if(pw.equals(rs_pw)) return hb_code;
					else return 0;
				}
			}
			else if(user_code.equals("직원")) {
				rs = pstmt.executeQuery();
				
				// 일치하는 id 있을경우
				if(rs.next()) {
					String rs_pw = rs.getString("pw");
					if(pw.equals(rs_pw)) {
						hb_code = rs.getInt("staff_code");
						return hb_code;
					}
					else return 0;
				}
			}
			return 0;
		} finally {
			closeAll();
		}
	}
	
	public HanbitUserDTO getUserInfo(String user_code, String id) throws ClassNotFoundException, SQLException {
		String sql = null;
		HanbitUserDTO bean = new HanbitUserDTO();
		if(user_code.equals("학생")) sql = "select name, gender from student where id=? and approve=1";
		else sql = "select name, gender, staff_code from employee where id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				if(user_code.equals("학생")) bean.setHb_code(1);
				else bean.setHb_code(rs.getInt("staff_code"));
			}
		} finally {
			closeAll();
		}
		return bean;		
	}
	
	public int getTodayAttendanceInfo(String id) throws ClassNotFoundException, SQLException {
		String sql = "select count(*) as cnt from student, attend where student.id=attend.stu_id and ";
				sql += "attend.curdate=current_date() and student.id=? and approve=1";
		
		int result = 0;
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
		} finally {
			closeAll();
		}
		return result;
	}
	
	public void updateTodayAttendanceInfo(String id, String class_code) throws ClassNotFoundException, SQLException {
		String sql = "insert into attend(curdate,stu_id,class_code) values(current_date(),?,?)";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, class_code);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
}
