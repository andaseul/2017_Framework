package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/edit_question.hb")
public class EditQuestion extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int index = Integer.parseInt((String) req.getParameter("index"));
		String sub_code = (String) req.getParameter("subcode_"+index);
		String qcode = (String) req.getParameter("qcode_"+index);
		String question = (String) req.getParameter("question_"+index);
		String ex1 = (String) req.getParameter("ex1_"+index);
		String ex2 = (String) req.getParameter("ex2_"+index);
		String ex3 = (String) req.getParameter("ex3_"+index);
		String ex4 = (String) req.getParameter("ex4_"+index);
		String ex5 = (String) req.getParameter("ex5_"+index);
		int answer = Integer.parseInt((String) req.getParameter("answer"+index));
		
		TeacherDAO dao = new TeacherDAO();
		int result = 0;
		try {
			result = dao.updateQuestion(qcode, question, ex1, ex2, ex3, ex4, ex5, answer);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		if(result > 0) {
			resp.sendRedirect("detail_question.hb?sub_code="+sub_code);
		}
		
	}
	
}
