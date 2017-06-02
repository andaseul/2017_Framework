package com.team1.lms.jobsupport;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.JobSupportDAO;

/**
 * Servlet implementation class stu_job_update
 */
@WebServlet(name = "stu_job_update.hb", urlPatterns = { "/hb/stu_job_update.hb" })
public class StudentJobUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		request.setCharacterEncoding("UTF-8");
		int stu_job_size = Integer.parseInt((String)request.getParameter("stu_job_size"));
		String[]id = new String [stu_job_size];

		int[] job = new int[stu_job_size];
		JobSupportDAO dao = new JobSupportDAO();
		
		for(int i = 0; i<stu_job_size;i++){
			id[i]=(String)request.getParameter("id"+i);
			String stu_job = (String)request.getParameter("job"+i);
			if(stu_job.equals("구직자")) job[i]=0;
			else if(stu_job.equals("취업성공")) job[i]=1;
			
			try{
				dao.str_job_update(id[i], job[i]);

			}catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect("stu_job_bbs.hb?page=1");
	}

}
