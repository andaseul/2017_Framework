package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;

@WebServlet("/hb/notice_update.hb")
public class NoticeUpdate extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt((String) req.getParameter("idx").trim());
		int hit = Integer.parseInt((String) req.getParameter("hit").trim());
		String title = (String) req.getParameter("title");
		String memo = (String) req.getParameter("memo");
		
		AdministrationDAO dao = new AdministrationDAO();
		try {
			dao.admin_update(idx, title, memo);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("notice_detail.hb?idx=" + idx + "&hit=" + hit);
	}
	
}
