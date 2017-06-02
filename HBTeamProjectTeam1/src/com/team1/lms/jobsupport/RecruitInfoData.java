package com.team1.lms.jobsupport;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.team1.admin.dao.JobSupportDAO;

@WebServlet("/hb/recruitInfowrite_data.hb")
public class RecruitInfoData extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int result = 0;
		MultipartRequest multi = null;
		String savePath = req.getRealPath("/upload/recruit").replaceAll("\\\\", "/");
		int sizeLimit = 5 * 1024 * 1024;
		
		try {
			multi = new MultipartRequest(req, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String title = multi.getParameter("title");
		String memo = multi.getParameter("memo");
		String file = multi.getFilesystemName("file");
		String username = "Ãë¾÷Áö¿øÆÀ";
		int file_size = (int) (new File(savePath + "/" + file).length());
		
		try {
			JobSupportDAO dao = new JobSupportDAO();
			result = dao.insert_recruitInfobbs_data(title, username, memo, file, file_size);
		} catch (SQLException | ClassNotFoundException e){
			e.printStackTrace();
			
		}
		
		if(result > 0) {
			resp.sendRedirect("recruitInfo_bbs.hb?page=1");
		}	
	}
	
}
