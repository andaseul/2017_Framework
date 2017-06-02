package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;
import com.team1.admin.dto.Admin_NoticeDTO;
import com.team1.admin.dto.PageDTO;

@WebServlet("/hb/notice_bbs.hb")
public class NoticeBBS extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int page = Integer.parseInt(req.getParameter("page"));
		int cnt = 0;
		
		AdministrationDAO dao = new AdministrationDAO();
		List<Admin_NoticeDTO> list = null;
		PageDTO dto = null; 
		try {
			list = dao.admin_list(page);
			cnt = dao.countall("notice_bbs");
			dto = dao.page_detail(page, cnt);
		} catch (SQLException e){
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		};
		req.setAttribute("alist", list);
		req.setAttribute("page_detail", dto);
		req.getRequestDispatcher("/notice_bbs.jsp").forward(req, resp);
	}
	
}
