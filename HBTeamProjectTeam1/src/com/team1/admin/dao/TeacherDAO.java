package com.team1.admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.team1.admin.dto.Admin_StudentAttendanceDTO;
import com.team1.admin.dto.ClassNoticeDTO;
import com.team1.admin.dto.ClassQABBSDTO;
import com.team1.admin.dto.PageDTO;
import com.team1.admin.dto.QuestionDTO;
import com.team1.admin.dto.ScoreDTO;
import com.team1.admin.dto.SubjectDTO;
import com.team1.model.HanbitDB;

public class TeacherDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public TeacherDAO() {
		// TODO Auto-generated constructor stub
	}
	
	private void closeAll() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
	
	public int updateQuestion(String qcode, String question, String ex1, String ex2, String ex3, String ex4, String ex5, int answer) throws ClassNotFoundException, SQLException {
		String sql = "update question set question=?, example1=?, example2=?, example3=?, example4=?, example5=?, answer=? where qcode=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, question);
			pstmt.setString(2, ex1);
			pstmt.setString(3, ex2);
			pstmt.setString(4, ex3);
			pstmt.setString(5, ex4);
			pstmt.setString(6, ex5);
			pstmt.setInt(7, answer);
			pstmt.setString(8, qcode);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int countall(String table, String class_code) {
		String sql = "select count(*) from " + table + " where class_code=?";
		int allcount =0;
		try {
			conn = HanbitDB.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
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
	
	public void classqabbs_del(int idx) throws SQLException, ClassNotFoundException {
		String sql = "select grp, seq from classqabbs where idx=?";
		int grp = 0;
		int seq = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				grp = rs.getInt("grp");
				seq = rs.getInt("seq");
			}
		} finally {
			closeAll();
		}
		
		if(seq==1) sql = "delete from classqabbs where grp=?";
		else sql = "delete from classqabbs where idx=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			if(seq==1) pstmt.setInt(1, grp);
			else pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public List<ClassQABBSDTO> classqabbs_list(String class_code, int page) throws ClassNotFoundException, SQLException {

		List<ClassQABBSDTO> list = new ArrayList<ClassQABBSDTO>();
		String sql = "select idx, name, title, curdate, curtime, hit, lvl from classqabbs where class_code=? order by grp desc, seq limit ?, 10";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			pstmt.setInt(2, page*10-10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ClassQABBSDTO bean = new ClassQABBSDTO();
				bean.setIdx(rs.getInt("idx"));
				bean.setUsername(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
				bean.setCurdate(rs.getDate("curdate").toString());
				bean.setCurtime(rs.getTime("curtime").toString());
				bean.setHit(rs.getInt("hit"));
				bean.setLvl(rs.getInt("lvl"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;

	}

	public void classqabbs_reple(int idx, String title, String username, String memo, String class_code) throws ClassNotFoundException, SQLException{
		int grp = 0, seq = 0, lvl = 0;
		
		String sql = "select grp, seq, lvl from classqabbs where idx=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				grp = rs.getInt(1);
				seq = rs.getInt(2);
				lvl = rs.getInt(3);	
			}	
		} finally {
			closeAll();
		}
		
		sql = "update classqabbs set seq=seq+1 where grp=? and seq>?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, grp);
			pstmt.setInt(2, seq);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		
		sql = "insert into classqabbs(curdate, curtime, name, title, memo, grp, seq, lvl, class_code) values (current_date(), current_time(), ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, title);
			pstmt.setString(3, memo);
			pstmt.setInt(4, grp);
			pstmt.setInt(5, seq+1);
			pstmt.setInt(6, lvl+1);
			pstmt.setString(7, class_code);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public int insert_classqabbs_data(String title, String username, String memo, String file, int file_size, String class_code) throws ClassNotFoundException, SQLException {
		int result = 0;
		int max = 0;
		
		String sql = "select max(grp) from classqabbs";
		
		try	{
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				max = rs.getInt(1);
			}
			
			sql = "insert into classqabbs (curdate, curtime, title, name, memo, file, file_size, grp, class_code)";
			sql += "values(current_date(), current_time(), ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, username);
			pstmt.setString(3, memo);
			pstmt.setString(4, file);
			pstmt.setInt(5, file_size);
			pstmt.setInt(6, max+1);
			pstmt.setString(7, class_code);
			result =pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}

	public void classqabbs_hit_count(int idx, int hit) throws ClassNotFoundException, SQLException {
		String sql = "update classqabbs set hit=? where idx=?";

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

	public ClassQABBSDTO classqabbs_detail(int idx) throws ClassNotFoundException, SQLException {
		ClassQABBSDTO bean = new ClassQABBSDTO();
		String sql = "select name, title, curdate, curtime, memo, hit, file from classqabbs where idx=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setIdx(idx);
				bean.setUsername(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
				bean.setCurdate(rs.getDate("curdate").toString());
				bean.setCurtime(rs.getTime("curtime").toString());
				bean.setMemo(rs.getString("memo"));
				bean.setHit(rs.getInt("hit"));
				bean.setFile(rs.getString("file"));
			}
		} finally {
			closeAll();
		}
		return bean;
	}

	public void classqabbs_edit(String idx, String title, String memo, String file, int file_size) throws SQLException, ClassNotFoundException {
		String sql = "update classqabbs set title=?, memo=?, file=?, file_size=? where idx=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, memo);
			pstmt.setString(3, file);
			pstmt.setInt(4, file_size);
			pstmt.setInt(5, Integer.parseInt(idx));
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public int classbbs_count() throws ClassNotFoundException, SQLException{
		int cnt = 0;
		String sql = "select count(*) from classnotice_bbs";
		
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
	
	public List<ClassNoticeDTO> classbbs_list(String class_code, int page) throws SQLException, ClassNotFoundException {
		List<ClassNoticeDTO> list = new ArrayList<ClassNoticeDTO>();
		String sql="SELECT IDX, NAME, TITLE, curdate, curtime, HIT FROM classnotice_bbs where class_code=? order by idx desc limit ?, 10";
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			pstmt.setInt(2, page*10-10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				ClassNoticeDTO bean = new ClassNoticeDTO();
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
	
	
	public int insert_classbbs_data(String title, String name, String memo, String class_code) throws ClassNotFoundException, SQLException{
		int result = 0;
		String sql = "insert into classnotice_bbs (title, name, memo, hit, curdate, curtime, class_code) values(?, ?, ?, ?, current_date(), current_time(), ?)";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, name);
			pstmt.setString(3, memo);
			pstmt.setInt(4, 0);
			pstmt.setString(5, class_code);
			result =pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	
	public ClassNoticeDTO classbbs_detail(int idx) throws ClassNotFoundException, SQLException{
		ClassNoticeDTO bean = new ClassNoticeDTO();
		String sql = "select * from classnotice_bbs where idx=?";
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
		String sql = "update classnotice_bbs set hit =? where idx = ?";
		
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
	
	public void classbbs_del(int idx) throws SQLException, ClassNotFoundException {
		String sql = "delete from classnotice_bbs where idx=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public void classbbs_update(int idx,String title, String memo) throws SQLException, ClassNotFoundException {
		String sql ="update classnotice_bbs set title=?,memo=? where idx=?";
		
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
	
	public int editScore(String id, String sub_code, int score) throws ClassNotFoundException, SQLException {
		String sql = "update stu_grade set score=? where id=? and sub_code=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, score);
			pstmt.setString(2, id);
			pstmt.setString(3, sub_code);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public ArrayList<ScoreDTO> getStudentScoreInfo(String sub_code) throws ClassNotFoundException, SQLException {
		ArrayList<ScoreDTO> list = new ArrayList<ScoreDTO>();
		String sql = "select stu_grade.id, student.name, stu_grade.score, stu_grade.total_score from student, stu_grade where student.id=stu_grade.id and sub_code=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sub_code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ScoreDTO bean = new ScoreDTO();
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setScore(rs.getInt("score"));
				bean.setTotal_score(rs.getInt("total_score"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public int updateStudentAttInfo(String id, int state) throws ClassNotFoundException, SQLException {
		String sql = "update attend set state=? where stu_id=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, state);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int addExam(String sub_code) throws ClassNotFoundException, SQLException {
		String sql = "update subject set exam=1 where code=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sub_code);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public ArrayList<String> getTitle(String sub_code) throws ClassNotFoundException, SQLException {
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select class.title as class_title, subject.title as subject_title from class, subject where class.code=subject.class_code and subject.code=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sub_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list.add(rs.getString("class_title"));
				list.add(rs.getString("subject_title"));
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public ArrayList<QuestionDTO> getQuestionInfo(String sub_code) throws ClassNotFoundException, SQLException {
		ArrayList<QuestionDTO> list = new ArrayList<QuestionDTO>();
		String sql = "select * from question where sub_code=? order by qcode";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sub_code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				QuestionDTO bean = new QuestionDTO();
				bean.setSub_code(sub_code);
				bean.setQcode(rs.getString("qcode"));
				bean.setQuestion(rs.getString("question"));
				bean.setEx1(rs.getString("example1"));
				bean.setEx2(rs.getString("example2"));
				bean.setEx3(rs.getString("example3"));
				bean.setEx4(rs.getString("example4"));
				bean.setEx5(rs.getString("example5"));
				bean.setAnswer(rs.getInt("answer"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;		
	}
	
	public int insertQuestion(String sub_code, String qcode, String question, String ex1, String ex2, String ex3, String ex4, String ex5, int answer) throws SQLException, ClassNotFoundException {
		String sql = "insert into question values(?,?,?,?,?,?,?,?,?)";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qcode);
			pstmt.setString(2, question);
			pstmt.setString(3, ex1);
			pstmt.setString(4, ex2);
			pstmt.setString(5, ex3);
			pstmt.setString(6, ex4);
			pstmt.setString(7, ex5);
			pstmt.setInt(8, answer);
			pstmt.setString(9, sub_code);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int getQuestionCnt(String sub_code) throws ClassNotFoundException, SQLException {
		String sql = "select count(question) as cnt from question where sub_code=? order by qcode";
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
	
	public ArrayList<SubjectDTO> getSubjectInfo(String class_code) throws ClassNotFoundException, SQLException {
		ArrayList<SubjectDTO> list = new ArrayList<SubjectDTO>();
		String sql = "select subject.code, subject.title, subject.class_code, subject.exam, class.title from class, subject where class.code=subject.class_code and subject.class_code=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SubjectDTO bean = new SubjectDTO();
				bean.setCode(rs.getString("subject.code"));
				bean.setTitle(rs.getString("subject.title"));
				bean.setClass_code(rs.getString("subject.class_code"));
				bean.setExam(rs.getInt("subject.exam"));
				bean.setClass_title(rs.getString("class.title"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public String getClassCode(String id) throws ClassNotFoundException, SQLException {
		String sql = "select class_code from teacher where id=?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			} else return null;
		} finally {
			closeAll();
		}
	}
	
	public ArrayList<String> getClassStudent(String class_code) throws ClassNotFoundException, SQLException {
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select id from student where class_code=? order by name";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("id"));
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public ArrayList<String> getAttendStudent(String class_code) throws ClassNotFoundException, SQLException {
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select id from student left outer join attend on student.id=attend.stu_id where student.class_code=? and attend.curdate=current_date() order by name desc";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("id"));
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public void setAttendStuInfo(ArrayList<String> list, String class_code) throws ClassNotFoundException, SQLException {
		String sql = "insert into attend(curdate,stu_id,class_code) values(current_date(),?,?)";
	
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			for(int i=0; i<list.size(); i++) {
				pstmt.setString(1, list.get(i));
				pstmt.setString(2, class_code);
				pstmt.executeUpdate();
			}
			
		} finally {
			closeAll();
		}		
	}
	
	public ArrayList<Admin_StudentAttendanceDTO> getAttendState(String class_code, String curdate) throws ClassNotFoundException, SQLException {
		ArrayList<Admin_StudentAttendanceDTO> list = new ArrayList<Admin_StudentAttendanceDTO>();
		
		String sql = "select st.id, st.name, at.curtime, at.state from student as st left outer join attend as at";
		sql += " on st.id=at.stu_id where st.class_code=? and at.curdate=current_date() order by st.name";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
//			pstmt.setString(2, curdate);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Admin_StudentAttendanceDTO bean = new Admin_StudentAttendanceDTO();
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				String curtime;
				if((curtime = rs.getString("curtime")) != null) {
					bean.setTime(curtime);
				} else bean.setTime("-");
				bean.setState(rs.getInt("state"));
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		
		return list;
	}
}
