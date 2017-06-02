package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;
import com.team1.admin.dto.ScoreDTO;

@WebServlet("/hb/detail_score.hb")
public class TeacherDetailScore extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String sub_code = (String) req.getParameter("sub_code");
		String title = (String) req.getParameter("title");
		
		TeacherDAO dao = new TeacherDAO();
		try {
			ArrayList<ScoreDTO> list = dao.getStudentScoreInfo(sub_code);
			req.setAttribute("score_list", list);
			req.setAttribute("sub_code", sub_code);
			req.setAttribute("title", title);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/detail_score.jsp").forward(req, resp);
	}
	
}
