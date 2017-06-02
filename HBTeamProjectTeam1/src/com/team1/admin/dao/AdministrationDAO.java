package com.team1.admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.team1.admin.dto.Admin_NoticeDTO;
import com.team1.admin.dto.Admin_StudentAttListDTO;
import com.team1.admin.dto.ClassDTO;
import com.team1.admin.dto.ClassStudentDTO;
import com.team1.admin.dto.EmployeeDTO;
import com.team1.admin.dto.PageDTO;
import com.team1.admin.dto.StudentInfoDTO;
import com.team1.model.HanbitDB;
import com.team1.student.dto.StudentDetailAttendanceDTO;

public class AdministrationDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public AdministrationDAO() {
		// TODO Auto-generated constructor stub
	}
	
	private void closeAll() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
	
	public void insertSubject(String class_code, String code, String title) throws ClassNotFoundException, SQLException {
		String sql = "insert into subject values (?, ?, ?, ?)";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			pstmt.setString(2, title);
			pstmt.setString(3, class_code);
			pstmt.setInt(4, 0);
		} finally {
			closeAll();
		}
	}
	
	public int updateClassInfo(String code, String title, String teacher, int limit, String start_date, String end_date, int attendance_day) throws ClassNotFoundException, SQLException {
		String sql = "update class set title=?, teacher_name=?, limit_num=?, start_date=?, end_date=?, attendance_day=? where code=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, teacher);
			pstmt.setInt(3, limit);
			pstmt.setString(4, start_date);
			pstmt.setString(5, end_date);
			pstmt.setInt(6, attendance_day);
			pstmt.setString(7, code);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public ArrayList<ClassStudentDTO> getClassStudentInfo(String class_code) throws ClassNotFoundException, SQLException {
		ArrayList<ClassStudentDTO> list = new ArrayList<ClassStudentDTO>();
		String sql = "select student.id, student.name, birthday, job, phone from student, student_job where student.id=student_job.id and class_code=? and approve=1";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ClassStudentDTO bean = new ClassStudentDTO();
				bean.setId(rs.getString("student.id"));
				bean.setName(rs.getString("student.name"));
				bean.setBirthday(rs.getDate("birthday").toString());
				if(rs.getInt("job")==0) bean.setJob("구직자");
				else bean.setJob("취업자");
				bean.setPhone(rs.getString("phone"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public ClassDTO getClassInfo(String class_code) throws ClassNotFoundException, SQLException {
		String sql = "select * from class where code=?";
		ClassDTO bean = new ClassDTO();
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setCode(class_code);
				bean.setAttendance_day(rs.getInt("attendance_day"));
				bean.setCur_stunum(rs.getInt("cur_stunum"));
				bean.setEnd_date(rs.getDate("end_date").toString());
				bean.setLimit(rs.getInt("limit_num"));
				bean.setStart_date(rs.getDate("start_date").toString());
				bean.setTeacher_name(rs.getString("teacher_name"));
				bean.setTitle(rs.getString("title"));
			}
		} finally {
			closeAll();
		}
		return bean;
	}
	
	public int updateStaffInfo(String id, String name, String phone, String address, String mail, String account_name, String account) throws ClassNotFoundException, SQLException {
		int result = 0;
		String sql = "update employee set name=?, phone=?, address=?, mail=?, account_name=?, account=? where id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			pstmt.setString(3, address);
			pstmt.setString(4, mail);
			pstmt.setString(5, account_name);
			pstmt.setString(6, account);
			pstmt.setString(7, id);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int updateStudentInfo(String id, String name, String phone, String address, String mail) throws ClassNotFoundException, SQLException {
		int result = 0;
		String sql = "update student set name=?, phone=?, address=?, mail=? where id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			pstmt.setString(3, address);
			pstmt.setString(4, mail);
			pstmt.setString(5, id);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public void updateClassAttInfo(String class_code, ArrayList<String> curdate, ArrayList<Integer> month) throws ClassNotFoundException, SQLException {
		String sql = "insert into attend_info values(?, ?, ?)";
		
//			System.out.println("class_code : " + class_code);
//			System.out.println("curdate : " + curdate.get(i));
//			System.out.println("curmonth : " + month.get(i));	
		try {
			conn = HanbitDB.getConnection();
			for(int i=0; i<curdate.size(); i++) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, curdate.get(i));
				pstmt.setInt(2, month.get(i));
				pstmt.setString(3, class_code);
				pstmt.executeUpdate();
			}
		} finally {
			closeAll();
		}	
	}
	
	public int deleteEmployee(String id) throws ClassNotFoundException, SQLException {
		String sql = "delete from employee where id=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int deleteStudent(String id) throws ClassNotFoundException, SQLException {
		String sql = "delete from student where id=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public StudentInfoDTO getStudentDetailInfo(String id) throws ClassNotFoundException, SQLException {
		StudentInfoDTO bean = new StudentInfoDTO();
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
			}
		} finally {
			closeAll();
		}
		return bean;
	}
	
	public ArrayList<StudentInfoDTO> getStudentInfo(int page, String search, String keyword) throws ClassNotFoundException, SQLException {
		if(search.equals("id")) search = "stu.id";
		else if(search.equals("name")) search = "stu.name";
		else if(search.equals("class_code")) search = "stu.class_code";
		
		ArrayList<StudentInfoDTO> list = new ArrayList<StudentInfoDTO>();
		String sql = "select * from student as stu, class where stu.class_code=class.code and stu.approve=1 and ";
				sql += search + " like '%" + keyword + "%' order by stu.class_code limit ?, 10";
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page*10-10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				StudentInfoDTO bean = new StudentInfoDTO();
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
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public ArrayList<StudentInfoDTO> getStudentInfo(int page) throws ClassNotFoundException, SQLException {
		ArrayList<StudentInfoDTO> list = new ArrayList<StudentInfoDTO>();
		String sql = "select * from student as stu, class where stu.class_code=class.code and stu.approve=1 order by stu.class_code limit ?, 10";
			
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page*10-10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				StudentInfoDTO bean = new StudentInfoDTO();
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
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public EmployeeDTO getEmployeeDetailInfo(String id) throws ClassNotFoundException, SQLException {
		EmployeeDTO bean = new EmployeeDTO();
		String sql = "select * from employee as emp, staff where emp.staff_code=staff.staff_code and emp.id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setId(rs.getString("emp.id"));
				bean.setName(rs.getString("emp.name"));
				bean.setAddress(rs.getString("emp.address"));
				bean.setBirthday(rs.getDate("emp.birthday").toString());
				bean.setGender(rs.getString("emp.gender"));
				bean.setStaff_code(rs.getInt("emp.staff_code"));
				bean.setMail(rs.getString("emp.mail"));
				bean.setPw(rs.getString("emp.pw"));
				bean.setTeam(rs.getString("staff.staff_name"));
				bean.setAccount_name(rs.getString("emp.account_name"));
				bean.setAccount(rs.getString("emp.account"));
				bean.setJoindate(rs.getDate("emp.joindate").toString());
				bean.setPhone(rs.getString("emp.phone"));
			}
		} finally {
			closeAll();
		}
		return bean;
	}
	
	public ArrayList<EmployeeDTO> getEmployeeInfo() throws ClassNotFoundException, SQLException {
		ArrayList<EmployeeDTO> list = new ArrayList<EmployeeDTO>();
		String sql = "select * from employee as emp, staff where emp.staff_code=staff.staff_code";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EmployeeDTO bean = new EmployeeDTO();
				bean.setId(rs.getString("emp.id"));
				bean.setName(rs.getString("emp.name"));
				bean.setAddress(rs.getString("emp.address"));
				bean.setBirthday(rs.getDate("emp.birthday").toString());
				bean.setGender(rs.getString("emp.gender"));
				bean.setStaff_code(rs.getInt("emp.staff_code"));
				bean.setMail(rs.getString("emp.mail"));
				bean.setPw(rs.getString("emp.pw"));
				bean.setTeam(rs.getString("staff.staff_name"));
				bean.setAccount_name(rs.getString("emp.account_name"));
				bean.setAccount(rs.getString("emp.account"));
				bean.setJoindate(rs.getDate("emp.joindate").toString());
				bean.setPhone(rs.getString("emp.phone"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public int admin_count() throws ClassNotFoundException, SQLException{
		int cnt = 0;
		String sql = "select count(*) from notice_bbs";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				cnt = rs.getInt(1);
			}
		} finally {
			closeAll();
		}
		return cnt;
	}
	
	public int st_countall() {
		String sql = "select count(*) from student, class where student.class_code=class.code";
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
	
	public int countall(String table) {
		String sql = "select count(*) from " + table;
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

	public List<Admin_NoticeDTO> admin_list(int page) throws SQLException, ClassNotFoundException {
		List<Admin_NoticeDTO> list = new ArrayList<Admin_NoticeDTO>();
		String sql="SELECT IDX, NAME, TITLE, curdate, curtime, HIT FROM notice_bbs order by idx desc limit ?, 10";
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page*10-10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Admin_NoticeDTO bean = new Admin_NoticeDTO();
				bean.setIdx(rs.getInt("idx"));
				bean.setUsername(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
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
	
	
	public int insert_admin_data(String title, String name, String memo) throws ClassNotFoundException, SQLException{
		int result = 0;
		String sql = "insert into notice_bbs (title, name, memo, hit, curdate, curtime) values(?, ?, ?, ?,current_date(), current_time())";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, name);
			pstmt.setString(3, memo);
			pstmt.setInt(4, 0);
			result =pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	
	public Admin_NoticeDTO admin_detail(int idx) throws ClassNotFoundException, SQLException{
		Admin_NoticeDTO bean = new Admin_NoticeDTO();
		String sql = "select * from notice_bbs where idx=?";
		try{
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				bean.setIdx(rs.getInt("idx"));
				bean.setUsername(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
				bean.setCurdate(rs.getDate("curdate").toString());
				bean.setCurtime(rs.getTime("curtime").toString());
				bean.setMemo(rs.getString("memo"));
				bean.setHit(rs.getInt("hit"));
			}
		}finally{
			closeAll();
		}
		return bean;
	}
	

	public void hit_count(int idx,int hit) throws ClassNotFoundException, SQLException{
		String sql = "update notice_bbs set hit =? where idx = ?";
		
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
	
	public void admin_del(int idx) throws SQLException, ClassNotFoundException {
		String sql = "delete from notice_bbs where idx=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public void admin_update(int idx,String title, String memo) throws SQLException, ClassNotFoundException {
		String sql ="update notice_bbs set title=?, memo=? where idx=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, memo);
			pstmt.setInt(3, idx);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public void updateStudentAttInfo(String id, String date, int state) throws ClassNotFoundException, SQLException {
		String sql = "update attend set state=? where stu_id=? and curdate=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, state);
			pstmt.setString(2, id);
			pstmt.setString(3, date);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public ArrayList<StudentDetailAttendanceDTO> getStudentAttDetailInfo(String id) throws ClassNotFoundException, SQLException {
		ArrayList<StudentDetailAttendanceDTO> list = new ArrayList<StudentDetailAttendanceDTO>();
		String sql = "select name, curdate, curtime, at.state from student as st, attend as at where st.id=at.stu_id and st.id=? and at.curdate<=current_date() order by curdate";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				StudentDetailAttendanceDTO bean = new StudentDetailAttendanceDTO();
				bean.setName(rs.getString("name"));
				bean.setCurdate(rs.getDate("curdate").toString());
				bean.setCurtime(rs.getTime("curtime").toString());
				bean.setState(rs.getInt("at.state"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public ArrayList<Admin_StudentAttListDTO> getStudentAttendInfo(int page, String search, String keyword) throws ClassNotFoundException, SQLException {
		if(search.equals("id")) search = "st.id";
		else if(search.equals("name")) search = "st.name";
		else if(search.equals("class_code")) search = "st.class_code";
		
		ArrayList<Admin_StudentAttListDTO> list = new ArrayList<Admin_StudentAttListDTO>();
		String sql = "select st.id, st.name, st.class_code, cl.title from student as st, class as cl ";
				sql += "where st.class_code=cl.code and st.approve=1 and " + search + " like '%" + keyword + "%' order by st.class_code limit ?, 10";
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page*10-10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Admin_StudentAttListDTO bean = new Admin_StudentAttListDTO();
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setClass_code(rs.getString("class_code"));
				bean.setTitle(rs.getString("title"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}		
		return list;
	}
	
	public ArrayList<Admin_StudentAttListDTO> getStudentAttendInfo(int page) throws ClassNotFoundException, SQLException {
		ArrayList<Admin_StudentAttListDTO> list = new ArrayList<Admin_StudentAttListDTO>();
		String sql = "select st.id, st.name, st.class_code, cl.title from student as st, class as cl where st.class_code=cl.code and st.approve=1 order by st.class_code limit ?, 10";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page*10-10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Admin_StudentAttListDTO bean = new Admin_StudentAttListDTO();
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setClass_code(rs.getString("class_code"));
				bean.setTitle(rs.getString("title"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}		
		return list;
	}
	
	public ArrayList<ClassDTO> selectAllClass() throws ClassNotFoundException, SQLException {
		ArrayList<ClassDTO> list = new ArrayList<ClassDTO>();
		String sql = "select * from class order by start_date";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ClassDTO bean = new ClassDTO();
				bean.setCode(rs.getString("code"));
				bean.setTitle(rs.getString("title"));
				bean.setTeacher_name(rs.getString("teacher_name"));
				bean.setStart_date(rs.getDate("start_date").toString());
				bean.setEnd_date(rs.getDate("end_date").toString());
				bean.setCur_stunum(rs.getInt("cur_stunum"));
				bean.setLimit(rs.getInt("limit_num"));
				bean.setAttendance_day(rs.getInt("attendance_day"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public ArrayList<String> getTeacherName() throws ClassNotFoundException, SQLException {
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select name from employee where staff_code=3 order by name";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString("name"));
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public int insertStaff(EmployeeDTO bean) throws ClassNotFoundException, SQLException {
		String sql = "insert into employee values (?,?,?,?,?,?,?,?,?,?,?,?)";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPw());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getGender());
			pstmt.setString(5, bean.getAddress());
			pstmt.setString(6, bean.getMail());
			pstmt.setString(7, bean.getBirthday());
			pstmt.setString(8, bean.getJoindate());
			pstmt.setString(9, bean.getAccount_name());
			pstmt.setString(10, bean.getAccount());
			pstmt.setString(11, bean.getPhone());
			pstmt.setInt(12, bean.getStaff_code());
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}		
		return result;
	}
	
	public int insertTeam(EmployeeDTO bean) throws ClassNotFoundException, SQLException {
		String[] team = {"administration", "teacher", "", "", "ceo"};
		String sql = "insert into " + team[bean.getStaff_code()-2] + "(id,name,staff_code) values (?,?,?)";
		int result = 0;
		
		try {			
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getName());
			pstmt.setInt(3, bean.getStaff_code());
			result = pstmt.executeUpdate();			
		} finally {
			closeAll();
		}		
		return result;
	}
	
	public int insertClass(ClassDTO bean) throws ClassNotFoundException, SQLException {
		String sql = "insert into class(code, title, teacher_name, start_date, end_date, attendance_day) values (?,?,?,?,?,?)";
		int result = 0;
		
		try {			
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getCode());
			pstmt.setString(2, bean.getTitle());
			pstmt.setString(3, bean.getTeacher_name());
			pstmt.setString(4, bean.getStart_date());
			pstmt.setString(5, bean.getEnd_date());
			pstmt.setInt(6, bean.getAttendance_day());
			result = pstmt.executeUpdate();			
		} finally {
			closeAll();
		}		
		return result;
	}
	
	public int updateTeacherClass(String class_code, String name) throws ClassNotFoundException, SQLException {
		String sql = "update teacher set class_code=? where name=?";
		int result = 0;
		
		try {			
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			pstmt.setString(2, name);
			result = pstmt.executeUpdate();			
		} finally {
			closeAll();
		}		
		return result;
	}
}
