package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;
import com.team1.admin.dto.Admin_NoticeDTO;

@WebServlet("/hb/notice_edit.hb")
public class NoticeEdit extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt((String) req.getParameter("idx").trim());
		
		AdministrationDAO dao = new AdministrationDAO();
		try {
			Admin_NoticeDTO bean = dao.admin_detail(idx);
			req.setAttribute("bean", bean);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		req.getRequestDispatcher("/notice_edit.jsp").forward(req, resp);
		
	}
	
}
