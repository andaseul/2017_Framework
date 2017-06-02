package com.team1.lms.sales;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.SalesDAO;
import com.team1.admin.dto.InquiryDTO;

@WebServlet("/hb/inquiry_detail.hb")
public class InquiryBBSDetail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		int hit = Integer.parseInt(req.getParameter("hit"));

		try {
			SalesDAO dao = new SalesDAO();
			dao.hit_count(idx, hit+1);
			InquiryDTO bean = dao.inquiry_detail(idx);
			req.setAttribute("dto", bean);
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/inquiry_detail.jsp").forward(req, resp);
		
		
	}
	
}
