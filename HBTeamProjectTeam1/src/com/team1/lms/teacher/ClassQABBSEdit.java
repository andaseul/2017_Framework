package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;
import com.team1.admin.dto.ClassQABBSDTO;

@WebServlet("/hb/classqa_edit.hb")
public class ClassQABBSEdit extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt((String) req.getParameter("idx").trim());
		
		TeacherDAO dao = new TeacherDAO();
		ClassQABBSDTO bean = null;
		
		try {
			bean = dao.classqabbs_detail(idx);
			req.setAttribute("bean", bean);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/classqa_edit.jsp").forward(req, resp);
	}
	
}
