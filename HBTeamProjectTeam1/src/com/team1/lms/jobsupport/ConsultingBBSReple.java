package com.team1.lms.jobsupport;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hb/consulting_reple.hb")
public class ConsultingBBSReple extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String idx = (String) req.getParameter("idx");
		req.setAttribute("idx", idx);
		req.getRequestDispatcher("/consulting_reple.jsp").forward(req, resp);
	}

}
