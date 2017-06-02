package com.team1.lms.jobsupport;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.JobSupportDAO;
import com.team1.admin.dto.RecruitInfoDTO;

@WebServlet("/hb/recruitInfo_edit.hb")
public class RecruitInfoEdit extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt((String) req.getParameter("idx").trim());
		
		JobSupportDAO dao = new JobSupportDAO();
		try {
			RecruitInfoDTO bean = dao.recruitInfobbs_detail(idx);
			req.setAttribute("bean", bean);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		req.getRequestDispatcher("/recruitInfo_edit.jsp").forward(req, resp);
		
	}
	
}
