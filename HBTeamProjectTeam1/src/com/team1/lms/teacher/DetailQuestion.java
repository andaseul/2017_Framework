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
import com.team1.admin.dto.QuestionDTO;

@WebServlet("/hb/detail_question.hb")
public class DetailQuestion extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String sub_code = (String) req.getParameter("sub_code");
		
		TeacherDAO dao = new TeacherDAO();
		try {
			ArrayList<QuestionDTO> list = dao.getQuestionInfo(sub_code);
			ArrayList<String> list2 = dao.getTitle(sub_code);
			req.setAttribute("qlist", list);
			req.setAttribute("class_title", list2.get(0));
			req.setAttribute("subject_title", list2.get(1));
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/detail_question.jsp").forward(req, resp);
	}
	
}
