package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;

@WebServlet("/hb/student_update.hb")
public class UpdateStudent extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String id = (String) req.getParameter("id");
		String name = (String) req.getParameter("name");
		String phone = (String) req.getParameter("phone");
		String address = (String) req.getParameter("address");
		String mail = (String) req.getParameter("mail");
		int result = 0;
		
		AdministrationDAO dao = new AdministrationDAO();
		try {
			result = dao.updateStudentInfo(id, name, phone, address, mail);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		if(result > 0) {
			resp.sendRedirect("admin_student_detailinfo.hb?id="+id);
		}
		
	}
	
}
