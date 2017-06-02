package com.team1.admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.team1.admin.dto.ConsultingBBSDTO;
import com.team1.admin.dto.PageDTO;
import com.team1.admin.dto.RecruitInfoDTO;
import com.team1.admin.dto.StudentJobDTO;
import com.team1.model.HanbitDB;

public class JobSupportDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public JobSupportDAO() {
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

	////////stu_job_list ¹ÝÈ¯
		
	public List<StudentJobDTO> stu_job_list(int page) throws ClassNotFoundException, SQLException {
	
		List<StudentJobDTO> list = new ArrayList<StudentJobDTO>();
		String sql = "select student.id, student.name, student.class_code, student_job.job from student, student_job where student.id=student_job.id order by name limit ?, 10";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page*10-10);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				StudentJobDTO bean = new StudentJobDTO();
				bean.setId(rs.getString("student.id"));
				bean.setName(rs.getString("student.name"));
				bean.setClass_code(rs.getString("student.class_code"));
				bean.setJob(rs.getInt("student_job.job"));
	
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	
	}
	
	public List<StudentJobDTO> stu_job_list(int page, String search, String keyword) throws ClassNotFoundException, SQLException {
		if(search.equals("id")) search = "student.id";
		else if(search.equals("name")) search = "student.name";
		else if(search.equals("class_code")) search = "student.class_code";
		
		List<StudentJobDTO> list = new ArrayList<StudentJobDTO>();
		String sql = "select student.id, student.name, student.class_code, student_job.job from student, student_job where student.id=student_job.id and ";
				sql += search + " like '%" + keyword + "%' order by student.name limit ?, 10";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page * 10-10);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				StudentJobDTO bean = new StudentJobDTO();
				bean.setId(rs.getString("student.id"));
				bean.setName(rs.getString("student.name"));
				bean.setClass_code(rs.getString("student.class_code"));
				bean.setJob(rs.getInt("student_job.job"));
	
				list.add(bean);
			}
		} finally {
			closeAll();
		}
		return list;
	
	}
	
	public int str_job_update(String id ,int job) throws ClassNotFoundException, SQLException {
		String sql = "update student_job set job=? where id=?";
		int result = 0;
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, job);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public double job_percent(int all, int job_suc, int job_fail){
		double result = ((double)job_suc) / all * 100.0;
		result = Math.round(result*100d)/100d;
		
		return result;
	}
	
	public ArrayList<String> getClassCode() throws SQLException {
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select code from class";
		
		try {
			conn = pstmt.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String class_code = rs.getString("code");
				list.add(class_code);
			}
		} finally {
			closeAll();
		}
		return list;
	}
	
	public int countall(String table, String class_code) {
		String sql = "select count(*) from " + table + " where class_code=? and approve=1";
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
	
	public  int count_jobsuccess(String class_code){
		String sql = "select count(*) from student, student_job where ";
				sql += "student.id=student_job.id and student.class_code=? and student_job.job=1 and student.approve=1";
		int cnt = 0;
		
		try{
			conn = HanbitDB.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, class_code);
			rs=pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public  int count_jobsuccess(){
		String sql = "select count(*) from student, student_job where student.id=student_job.id and student_job.job=1 and student.approve=1";
		int cnt = 0;
		
		try{
			conn = HanbitDB.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return cnt;
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
	
	public void consulting_del(int idx) throws SQLException, ClassNotFoundException {
		String sql = "select grp, seq from consultingbbs where idx=?";
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
		
		if(seq==1) sql = "delete from consultingbbs where grp=?";
		else sql = "delete from consultingbbs where idx=?";
		
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
	
	public List<ConsultingBBSDTO> consulting_list(int page) throws ClassNotFoundException, SQLException {

		List<ConsultingBBSDTO> list = new ArrayList<ConsultingBBSDTO>();
		String sql = "select idx, name, title, curdate, curtime, hit, lvl from consultingbbs order by grp desc, seq limit ?, 10";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page*10-10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ConsultingBBSDTO bean = new ConsultingBBSDTO();
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

	public void consulting_reple(int idx, String title, String username, String memo) throws ClassNotFoundException, SQLException{
		int grp = 0, seq = 0, lvl = 0;
		
		String sql = "select grp, seq, lvl from consultingbbs where idx=?";
		
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
		
		sql = "update consultingbbs set seq=seq+1 where grp=? and seq>?";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, grp);
			pstmt.setInt(2, seq);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		
		sql = "insert into consultingbbs(curdate, curtime, name, title, memo, grp, seq, lvl) values (current_date(), current_time(), ?, ?, ?, ?, ?, ?)";
		
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, title);
			pstmt.setString(3, memo);
			pstmt.setInt(4, grp);
			pstmt.setInt(5, seq+1);
			pstmt.setInt(6, lvl+1);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}
	
	public int insert_consulting_data(String title, String username, String memo, String file, int file_size) throws ClassNotFoundException, SQLException {
		int result = 0;
		int max = 0;
		
		String sql = "select max(grp) from consultingbbs";
		
		try	{
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				max = rs.getInt(1);
			}
			
			sql = "insert into consultingbbs (curdate, curtime, title, name, memo, file, file_size, grp)";
			sql += "values(current_date(), current_time(), ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, username);
			pstmt.setString(3, memo);
			pstmt.setString(4, file);
			pstmt.setInt(5, file_size);
			pstmt.setInt(6, max+1);
			result =pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}

	public void consulting_hit_count(int idx, int hit) throws ClassNotFoundException, SQLException {
		String sql = "update consultingbbs set hit=? where idx=?";

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

	public ConsultingBBSDTO consulting_detail(int idx) throws ClassNotFoundException, SQLException {
		ConsultingBBSDTO bean = new ConsultingBBSDTO();
		String sql = "select name, title, curdate, curtime, memo, hit, file from consultingbbs where idx=?";
		
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

	public void consulting_edit(String idx, String title, String memo, String file, int file_size) throws SQLException, ClassNotFoundException {
		String sql = "update consultingbbs set title=?, memo=?, file=?, file_size=? where idx=?";
		
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

	public int recruitInfobbs_count() throws ClassNotFoundException, SQLException {
		int cnt = 0;
		String sql = "select count(*) from recruitInfo_bbs";

		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				cnt = rs.getInt(1);
			}
		} finally {
			closeAll();
		}
		return cnt;
	}

	public List<RecruitInfoDTO> recruitInfobbs_list(int page) throws SQLException, ClassNotFoundException {
		List<RecruitInfoDTO> list = new ArrayList<RecruitInfoDTO>();
		String sql = "SELECT IDX, NAME, TITLE, curdate, curtime, HIT FROM recruitInfo_bbs order by idx desc limit ?, 10";
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page*10-10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				RecruitInfoDTO bean = new RecruitInfoDTO();
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

	public int insert_recruitInfobbs_data(String title, String name, String memo, String file, int file_size) throws ClassNotFoundException, SQLException {
		int result = 0;
		String sql = "insert into recruitInfo_bbs (title, name, memo, hit, curdate, curtime, file, file_size) values(?, ?, ?, ?, current_date(), current_time(), ?, ?)";
 
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, name);
			pstmt.setString(3, memo);
			pstmt.setInt(4, 0);
			pstmt.setString(5, file);
			pstmt.setInt(6, file_size);
			result = pstmt.executeUpdate();
		} finally {
			closeAll();
		}
		return result;
	}

	public RecruitInfoDTO recruitInfobbs_detail(int idx) throws ClassNotFoundException, SQLException {
		RecruitInfoDTO bean = new RecruitInfoDTO();
		String sql = "select * from recruitInfo_bbs where idx=?";
		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean.setIdx(rs.getInt("idx"));
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

	public void hit_count(int idx, int hit) throws ClassNotFoundException, SQLException {
		String sql = "update recruitInfo_bbs set hit =? where idx = ?";

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

	public void recruitInfobbs_del(int idx) throws SQLException, ClassNotFoundException {
		String sql = "delete from recruitInfo_bbs where idx=?";

		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}

	public void recruitInfobbs_update(String idx, String title, String memo, String file, int file_size) throws SQLException, ClassNotFoundException {
		String sql = "update recruitInfo_bbs set title=?, memo=?, file=?, file_size=? where idx=?";

		try {
			conn = HanbitDB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, memo);
			pstmt.setInt(3, Integer.parseInt(idx));
			pstmt.setString(4, file);
			pstmt.setInt(5, file_size);
			pstmt.executeUpdate();
		} finally {
			closeAll();
		}
	}

}
