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

@WebServlet("/hb/notice_detail.hb")
public class NoticeDetail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		int hit = Integer.parseInt(req.getParameter("hit"));

		try {
			AdministrationDAO dao = new AdministrationDAO();
			dao.hit_count(idx, hit+1);
			Admin_NoticeDTO bean = dao.admin_detail(idx);
			req.setAttribute("dto", bean);
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/notice_detail.jsp").forward(req, resp);
		
	}
	
}
