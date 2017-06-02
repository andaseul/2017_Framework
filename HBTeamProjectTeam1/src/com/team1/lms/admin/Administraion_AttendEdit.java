package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;

@WebServlet("/hb/admin_attedit.hb")
public class Administraion_AttendEdit extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String id = (String) req.getParameter("stu_id");
		String date = (String) req.getParameter("date");
		int state = Integer.parseInt((String) req.getParameter("chk_info"));
		
		AdministrationDAO dao = new AdministrationDAO();
		try {
			dao.updateStudentAttInfo(id, date, state);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("admin_att.hb?page=1");
	}
	
}
