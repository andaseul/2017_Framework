package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/edit_score.hb")
public class TeacherEditScore extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int index = Integer.parseInt((String) req.getParameter("index"));
		String sub_code = (String) req.getParameter("sub_code");
		String title = (String) req.getParameter("title");
		String id = (String) req.getParameter("id"+index);
		int score = Integer.parseInt((String) req.getParameter("score"+index));
		int result = 0;
		
		TeacherDAO dao = new TeacherDAO();
		try {
			result = dao.editScore(id, sub_code, score);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect("detail_score.hb?sub_code=" + sub_code + "&title=" + title);
		
	}
	
}
