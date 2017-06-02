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

@WebServlet("/hb/applicant_management.hb")
public class ApplicantManagement extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		ArrayList<ApplicantDTO> list = null;
		SalesDAO dao = new SalesDAO();
		
		try {
			list = dao.getApplicantInfo();
			req.setAttribute("list", list);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/sales_applicantmanagement.jsp").forward(req, resp);
		
	}
	
}
