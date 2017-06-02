package com.team1.admin.dto;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/add_exam.hb")
public class AddExam extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String sub_code = (String) req.getParameter("sub_code");
		
		TeacherDAO dao = new TeacherDAO();
		int result = 0;
		try {
			result = dao.addExam(sub_code);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(result > 0) resp.sendRedirect("teacher_exam_management.hb");
		
	}
	
}
