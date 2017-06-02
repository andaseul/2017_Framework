package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;

@WebServlet("/hb/staff_update.hb")
public class UpdateStaff extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String id = (String) req.getParameter("id");
		String name = (String) req.getParameter("name");
		String phone = (String) req.getParameter("phone");
		String address = (String) req.getParameter("address");
		String mail = (String) req.getParameter("mail");
		String account_name = (String) req.getParameter("account_name");
		String account = (String) req.getParameter("account");
		int result = 0;
		
		AdministrationDAO dao = new AdministrationDAO();
		try {
			result = dao.updateStaffInfo(id, name, phone, address, mail, account_name, account);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		if(result > 0) {
			resp.sendRedirect("admin_staff_detailinfo.hb?id="+id);
		}
		
	}
	
}
