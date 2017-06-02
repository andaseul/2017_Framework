package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/classnotice_del.hb")
public class ClassNoticeDelete extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		int idx=Integer.parseInt(req.getParameter("idx"));
		
		try {
			TeacherDAO dao = new TeacherDAO();
			dao.classbbs_del(idx);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("classnotice_bbs.hb?page=1");
		
	}
	
}
