package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;
import com.team1.admin.dto.EmployeeDTO;

@WebServlet("/hb/admin_staff_detailinfo.hb")
public class StaffDetailInfo extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String id = (String) req.getParameter("id");
		AdministrationDAO dao = new AdministrationDAO();
		try {
			EmployeeDTO bean = dao.getEmployeeDetailInfo(id);
			req.setAttribute("info", bean);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/admin_staffdetailinfo.jsp").forward(req, resp);
		
	}
	
}
