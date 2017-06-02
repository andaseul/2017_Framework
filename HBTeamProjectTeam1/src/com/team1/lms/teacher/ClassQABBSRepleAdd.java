package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/classqa_repleadd.hb")
public class ClassQABBSRepleAdd extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int idx =Integer.parseInt((String) req.getParameter("idx"));
		String title = (String) req.getParameter("title");
		String username = (String) req.getParameter("username");
		String memo = (String) req.getParameter("memo");
		
		HttpSession session = req.getSession();
		String class_code = (String) session.getAttribute("class_code");
		
		try {
			TeacherDAO dao= new TeacherDAO();
			dao.classqabbs_reple(idx, title, username, memo, class_code);
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("classqa_bbs.hb?page=1");
		
	}
	
}
