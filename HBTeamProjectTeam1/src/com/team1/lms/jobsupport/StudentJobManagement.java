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
import com.team1.admin.dto.StudentJobDTO;

/**
 * Servlet implementation class stu_job_bbs
 */
@WebServlet("/hb/stu_job_bbs.hb")
public class StudentJobManagement extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		JobSupportDAO dao = new JobSupportDAO();
		List<StudentJobDTO> list = null;
		int page = Integer.parseInt(req.getParameter("page"));
		int cnt = 0;
		PageDTO dto = null; 
		
		String keyword = (String) req.getParameter("keyword");
		String search = (String) req.getParameter("sel");
		
		try {
			if(keyword != null || search != null) {
				if(!search.equals("search")) {
					list = dao.stu_job_list(page, search, keyword);
				}
				else list = dao.stu_job_list(page);
			} else {
				list = dao.stu_job_list(page);
			}
			cnt = list.size();
			cnt = dao.countall("consultingbbs");
			dto = dao.page_detail(page, cnt);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		req.setAttribute("alist", list);
		req.setAttribute("page_detail", dto);
		req.getRequestDispatcher("/stu_job_bbs.jsp").forward(req, resp);
	}


}
