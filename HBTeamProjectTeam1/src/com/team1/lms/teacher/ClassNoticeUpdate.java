package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/classnotice_update.hb")
public class ClassNoticeUpdate extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt((String) req.getParameter("idx").trim());
		int hit = Integer.parseInt((String) req.getParameter("hit").trim());
		String title = (String) req.getParameter("title");
		String memo = (String) req.getParameter("memo");
		
		TeacherDAO dao = new TeacherDAO();
		try {
			dao.classbbs_update(idx, title, memo);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("classnotice_detail.hb?idx=" + idx + "&hit=" + hit);
	}
	
}
