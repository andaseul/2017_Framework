package com.team1.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hb/register_class.hb")
public class RegisterClass extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int class_code=Integer.parseInt((String)req.getParameter("class_code"));
		req.getRequestDispatcher("/join.jsp").forward(req, resp);
	}
	
}
