package com.team1.main;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.util.Hanbit_LMS_DAO;

@WebServlet("/hb/inquiry.hb")
public class HanbitInquiry extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String title = (String) req.getParameter("title");
		String name = (String) req.getParameter("name");
		String phone = (String) req.getParameter("phone");
		String memo = (String) req.getParameter("memo");
		
		Hanbit_LMS_DAO dao = new Hanbit_LMS_DAO();
		int result = 0;
		try {
			result = dao.insertInquiry(title, name, phone, memo);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		if(result > 0) {
			resp.sendRedirect("hanbit.hb");
		}
	}
	
}
