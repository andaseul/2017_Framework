package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/insert_question.hb")
public class InsertQuestion extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String sub_code = (String) req.getParameter("sub_code");
		String qcode = (String) req.getParameter("qcode").trim();
		String question = (String) req.getParameter("question").trim();
		String ex1 = (String) req.getParameter("ex1").trim();
		String ex2 = (String) req.getParameter("ex2").trim();
		String ex3 = (String) req.getParameter("ex3").trim();
		String ex4 = (String) req.getParameter("ex4").trim();
		String ex5 = (String) req.getParameter("ex5").trim();
		String str_answer = (String) req.getParameter("answer").trim();
		int answer = 0;
		
		if(str_answer.equals("ex1")) answer = 1;
		else if(str_answer.equals("ex2")) answer = 2;
		else if(str_answer.equals("ex3")) answer = 3;
		else if(str_answer.equals("ex4")) answer = 4;
		else if(str_answer.equals("ex5")) answer = 5;
		
		TeacherDAO dao = new TeacherDAO();
		try {
			int result = dao.insertQuestion(sub_code, qcode, question, ex1, ex2, ex3, ex4, ex5, answer);
			System.out.println("result : " + result);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("teacher_exam_management.hb");
	}
	
}
