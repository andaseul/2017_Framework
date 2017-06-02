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

@WebServlet("/hb/recruitInfo_update.hb")
public class RecruitInfoUpdate extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		MultipartRequest multi = null;
		String savePath = req.getRealPath("/upload/recruit").replaceAll("\\\\", "/");
		int sizeLimit = 5 * 1024 * 1024;
		
		try {
			multi = new MultipartRequest(req, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String idx = (String) multi.getParameter("idx");
		String hit = (String) multi.getParameter("hit");
		String title = (String) multi.getParameter("title");
		String memo = (String) multi.getParameter("memo");
		String file = (String) multi.getFilesystemName("file");
		int file_size = (int) (new File(savePath + "/" + file).length());
		
		
		JobSupportDAO dao = new JobSupportDAO();
		try {
			dao.recruitInfobbs_update(idx, title, memo, file, file_size);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("recruitInfo_detail.hb?idx=" + idx + "&hit=" + hit);
	}
	
}
