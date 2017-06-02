package com.team1.lms.teacher;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hb/classqa_reple.hb")
public class ClassQABBSReple extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String idx = (String) req.getParameter("idx");
		req.setAttribute("idx", idx);
		req.getRequestDispatcher("/classqa_reple.jsp").forward(req, resp);
	}

}
