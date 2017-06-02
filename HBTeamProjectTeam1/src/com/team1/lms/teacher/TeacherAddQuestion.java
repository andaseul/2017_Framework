package com.team1.lms.teacher;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hb/add_question.hb")
public class TeacherAddQuestion extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String sub_code = (String) req.getParameter("sub_code").trim();
		String title = (String) req.getParameter("title").trim();
		int qcnt = Integer.parseInt(req.getParameter("qcnt").trim());
		
		// 巩力 内靛积己
		String qcode = "";
		if(qcnt < 10) {
			qcode = sub_code + "-0" + (++qcnt);
		} else {
			qcode = sub_code + "-" + (++qcnt);
		}
		req.setAttribute("sub_code", sub_code);
		req.setAttribute("title", title);
		req.setAttribute("qcode", qcode);
		req.getRequestDispatcher("/add_question.jsp").forward(req, resp);
	}
	
}
