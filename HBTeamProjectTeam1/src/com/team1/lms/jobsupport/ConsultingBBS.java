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
import com.team1.admin.dto.ConsultingBBSDTO;
import com.team1.admin.dto.PageDTO;

@WebServlet("/hb/consulting_bbs.hb")
public class ConsultingBBS extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		JobSupportDAO dao = new JobSupportDAO();
		List<ConsultingBBSDTO> list = null;

		int page = Integer.parseInt(req.getParameter("page"));
		int cnt = 0;
		PageDTO dto = null; 
		try {
			list = dao.consulting_list(page);
			cnt = dao.countall("student_job");
			dto = dao.page_detail(page, cnt);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.setAttribute("alist", list);
		req.setAttribute("page_detail", dto);
		req.getRequestDispatcher("/consulting_bbs.jsp").forward(req, resp);
	}

}
