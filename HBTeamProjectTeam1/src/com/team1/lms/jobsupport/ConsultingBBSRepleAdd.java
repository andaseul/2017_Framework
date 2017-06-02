package com.team1.lms.jobsupport;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.JobSupportDAO;

@WebServlet("/hb/consulting_repleadd.hb")
public class ConsultingBBSRepleAdd extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int idx =Integer.parseInt((String) req.getParameter("idx"));
		String title = (String) req.getParameter("title");
		String username = (String) req.getParameter("username");
		String memo = (String) req.getParameter("memo");
		
		try {
			JobSupportDAO dao= new JobSupportDAO();
			dao.consulting_reple(idx, title, username, memo);
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("consulting_bbs.hb?page=1");
		
	}
	
}
