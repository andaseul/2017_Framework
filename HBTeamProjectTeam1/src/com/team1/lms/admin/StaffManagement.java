package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;
import com.team1.admin.dto.EmployeeDTO;

@WebServlet("/hb/staff_management.hb")
public class StaffManagement extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		
		AdministrationDAO dao = new AdministrationDAO();
		ArrayList<EmployeeDTO> list = new ArrayList<EmployeeDTO>();
		
		try {
			list = dao.getEmployeeInfo();
			req.setAttribute("list", list);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/admin_staffmanagement.jsp").forward(req, resp);
		
	}
	
}
