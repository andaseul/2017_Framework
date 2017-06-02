package com.team1.student.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.team1.model.HanbitDB;
import com.team1.student.dto.ExamListDTO;
import com.team1.student.dto.OnlineTestDTO;
import com.team1.student.dto.ScoreDTO;
import com.team1.student.dto.StudentAttendanceDTO;
import com.team1.student.dto.StudentDetailAttendanceDTO;

public class StudentDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public StudentDAO() {
		// TODO Auto-generated constructor stub
	}
	
	private void closeAll() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
	
	public int getQuaterAttinfo(String id) throws ClassNotFoundException, SQLException {
		int result = 0;
		String sql = "select count(*) as cnt from attend, attend_info where attend.curdate=attend_info.curdate ";
				sql += "and stu_id=? and attend_info.curmonth=month(current_date()) and state != 0";
		
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
	
	public int getQuaterAttCnt(String class_code) throws ClassNotFoundException, SQLException {
		int result = 0;
		String sql = "select count(*) as cnt from attend_info where class_code=? and curmonth=month(current_date())";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
		} finally {
			closeAll();
		}
		
		return result;
	}
	
	public String getTitle(String sub_code) throws ClassNotFoundException, SQLException {
		String sql = "select title from subject where code=?";
		String result = null;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sub_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString("title");
			}
		} finally {
			closeAll();
		}
		return result;
	}
	
	public ArrayList<ScoreDTO> getScoreInfo(String id) throws ClassNotFoundException, SQLException {
		ArrayList<ScoreDTO> list = new ArrayList<ScoreDTO>();
		String sql = "select sub_code, score, total_score from stu_grade where id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ScoreDTO bean = new ScoreDTO();
				bean.setSub_code(rs.getString("sub_code"));
				bean.setScore(rs.getInt("score"));
				bean.setTotal_score(rs.getInt("total_score"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public int getSubmitExamInfo(String id, String sub_code) throws ClassNotFoundException, SQLException {
		String sql = "select count(sub_code) as cnt from stu_grade where id=? and sub_code=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, sub_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int insertScore(String id, String sub_code, int score, int total_score) throws ClassNotFoundException, SQLException {
		String sql = "insert into stu_grade values (?,?,?,?)";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, sub_code);
			pstmt.setInt(3, score);
			pstmt.setInt(4, total_score);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int[] getExamAnswerList(String sub_code, int qcnt) throws ClassNotFoundException, SQLException {
		String sql = "select answer from question where sub_code=? order by qcode";
		int[] result = new int[qcnt];
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sub_code);
			rs = pstmt.executeQuery();
			int i = 0;
			while(rs.next()) {
				result[i++] = rs.getInt("answer");
			}
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int submitExamAnswer(String id, String qcode, String sub_code, int answer) throws ClassNotFoundException, SQLException {
		String sql = "insert into stu_exam values (?,?,?,?)";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, qcode);
			pstmt.setString(3, sub_code);
			pstmt.setInt(4, answer);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int getQcnt(String sub_code) throws ClassNotFoundException, SQLException {
		String sql = "select count(qcode) as cnt from question where sub_code=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sub_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
		} finally {
			closeAll();
		}		
		return result;
	}
	
	public ArrayList<OnlineTestDTO> getQuestionList(String sub_code) throws ClassNotFoundException, SQLException {
		ArrayList<OnlineTestDTO> list = new ArrayList<OnlineTestDTO>();
		String sql = "select qcode, question, example1, example2, example3, example4, example5 from question where sub_code=? order by qcode";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sub_code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OnlineTestDTO bean = new OnlineTestDTO();
				bean.setQcode(rs.getString("qcode"));
				bean.setQuestion(rs.getString("question"));
				bean.setEx1(rs.getString("example1"));
				bean.setEx2(rs.getString("example2"));
				bean.setEx3(rs.getString("example3"));
				bean.setEx4(rs.getString("example4"));
				bean.setEx5(rs.getString("example5"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public ArrayList<ExamListDTO> getOnlineTest(String class_code) throws ClassNotFoundException, SQLException {
		String sql = "select code, title from subject where class_code=? and exam=1 order by code";
		ArrayList<ExamListDTO> list = new ArrayList<ExamListDTO>();
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ExamListDTO bean = new ExamListDTO();
				bean.setSub_code(rs.getString("code"));
				bean.setTitle(rs.getString("title"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public StudentAttendanceDTO getClassInfo(String class_code) throws ClassNotFoundException, SQLException {
		StudentAttendanceDTO bean = new StudentAttendanceDTO();
		String sql = "select title, start_date, end_date, attendance_day from class where code=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setClass_title(rs.getString("title"));
				bean.setStart_date(rs.getString("start_date"));
				bean.setEnd_date(rs.getString("end_date"));
				bean.setFull_attend(rs.getInt("attendance_day"));
			}
		} finally {
			closeAll();
		}
		return bean;
	}
	
	public StudentAttendanceDTO getAttendanceInfo(String id) throws ClassNotFoundException, SQLException {
		StudentAttendanceDTO bean = new StudentAttendanceDTO();
		String sql = "select ";
			sql += "(select count(*) from attend where stu_id=? and state!=0 and curdate<=current_date()) as attend,";
			sql += "(select count(*) from attend where stu_id=? and (state=2 or state=3) and curdate<=current_date()) as late,";
			sql += "(select count(*) from attend where stu_id=? and state=0 and curdate<=current_date()) as absence "; 
			sql += "from attend where stu_id=?";
			
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			pstmt.setString(3, id);
			pstmt.setString(4, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setReal_attend(rs.getInt("attend"));
				bean.setLate(rs.getInt("late"));
				bean.setAbsence(rs.getInt("absence"));
			}
		} finally {
			closeAll();
		}		
		return bean;
	}
	
	public String stu_getClassCode(String stu_id) throws ClassNotFoundException, SQLException {
		String sql = "select class_code from student where id=?";
		String class_code = null;
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stu_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				class_code = rs.getString("class_code");
			}
			return class_code;
		} finally {
			closeAll();
		}		
	}
	
	public void request_attendance(String stu_id, int state) throws ClassNotFoundException, SQLException {
		String sql = "update attend set curtime=current_time(), state=? where stu_id=? and curdate=current_date()";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, state);
			pstmt.setString(2, stu_id);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		
	}
	
	public ArrayList<Object> getCurrAttendInfo(String id) throws ClassNotFoundException, SQLException {
		ArrayList<Object> list = new ArrayList<Object>();
		String sql = "select curdate, curtime, state from student, attend where student.id=attend.stu_id and curdate=current_date() and student.id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list.add(rs.getDate("curdate").toString());
				list.add(rs.getTime("curtime").toString());
				list.add(rs.getInt("state"));
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public ArrayList<StudentDetailAttendanceDTO> getDetailInfo(String id) throws ClassNotFoundException, SQLException {
		ArrayList<StudentDetailAttendanceDTO> list = new ArrayList<StudentDetailAttendanceDTO>();
		String sql = "select curdate, curtime, state from attend where stu_id=? and curdate<=current_date() order by curdate";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				StudentDetailAttendanceDTO bean = new StudentDetailAttendanceDTO();
				bean.setCurdate(rs.getDate("curdate").toString());
				bean.setCurtime(rs.getTime("curtime").toString());
				bean.setState(rs.getInt("state"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
}
