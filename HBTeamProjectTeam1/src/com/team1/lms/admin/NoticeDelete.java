package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;

@WebServlet("/hb/notice_del.hb")
public class NoticeDelete extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		int idx=Integer.parseInt(req.getParameter("idx"));
		
		try {
			AdministrationDAO dao = new AdministrationDAO();
			dao.admin_del(idx);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("notice_bbs.hb?page=1");
		
	}
	
}
