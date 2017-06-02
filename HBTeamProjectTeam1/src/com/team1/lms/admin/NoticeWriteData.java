package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;

@WebServlet("/hb/write_data.hb")
public class NoticeWriteData extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String title = (String) req.getParameter("title");
		String username = "ÇÑºû±³À° ÇàÁ¤ÆÀ";
		String memo = (String) req.getParameter("memo");
		
		int result = 0;
		
		try {
			AdministrationDAO dao = new AdministrationDAO();
			result = dao.insert_admin_data(title, username, memo);
		} catch (SQLException | ClassNotFoundException e){
			e.printStackTrace();
			
		}
		
		if(result > 0) {
			resp.sendRedirect("notice_bbs.hb?page=1");
		}	
	}
	
}
