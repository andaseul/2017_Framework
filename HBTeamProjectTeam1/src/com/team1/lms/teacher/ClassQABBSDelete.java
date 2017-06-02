package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/classqa_del.hb")
public class ClassQABBSDelete extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt((String) req.getParameter("idx"));
		
		TeacherDAO dao = new TeacherDAO();
		try {
			dao.classqabbs_del(idx);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("classqa_bbs.hb?page=1");
	}

}
