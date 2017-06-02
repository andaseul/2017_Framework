package com.team1.lms.sales;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.SalesDAO;

@WebServlet("/hb/inquiry_success.hb")
public class InquirySuccess extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		int idx=Integer.parseInt(req.getParameter("idx"));
		
		try {
			SalesDAO dao = new SalesDAO();
			dao.inquiry_succ(idx);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("inquiry_bbs.hb?page=1");
		
	}
	
}
