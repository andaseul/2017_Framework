package com.team1.lms.jobsupport;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.JobSupportDAO;
import com.team1.admin.dto.PageDTO;
import com.team1.admin.dto.RecruitInfoDTO;

@WebServlet("/hb/recruitInfo_bbs.hb")
public class RecruitInfoBBS extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		JobSupportDAO dao = new JobSupportDAO();
		List<RecruitInfoDTO> list = null;
		int page = Integer.parseInt(req.getParameter("page"));
		int cnt = 0;
		PageDTO dto = null; 
		try {
			list = dao.recruitInfobbs_list(page);
			cnt = dao.countall("recruitInfo_bbs");
			dto = dao.page_detail(page, cnt);
		} catch (SQLException e){
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		};
		req.setAttribute("alist", list);
		req.setAttribute("page_detail", dto);
		req.getRequestDispatcher("/recruitInfo_bbs.jsp").forward(req, resp);
	}
	
}
