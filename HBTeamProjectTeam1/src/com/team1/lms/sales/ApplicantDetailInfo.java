package com.team1.lms.sales;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.SalesDAO;
import com.team1.admin.dto.ApplicantDTO;

@WebServlet("/hb/sales_applicant_detailinfo.hb")
public class ApplicantDetailInfo extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String id = (String) req.getParameter("id");
		
		ApplicantDTO bean = null;
		SalesDAO dao = new SalesDAO();
		
		try {
			bean = dao.getApplicantDetailInfo(id);
			req.setAttribute("info", bean);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/sales_applicant_detailinfo.jsp").forward(req, resp);
	}
	
}
