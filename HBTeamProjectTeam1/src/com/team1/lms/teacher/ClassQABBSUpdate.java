package com.team1.lms.teacher;

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
import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/classqa_update.hb")
public class ClassQABBSUpdate extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		MultipartRequest multi = null;
		String savePath = req.getRealPath("/upload/classqa").replaceAll("\\\\", "/");
		int sizeLimit = 5 * 1024 * 1024;
		
		try {
			multi = new MultipartRequest(req, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String idx = (String) multi.getParameter("idx");
		String title = (String) multi.getParameter("title");
		String memo = (String) multi.getParameter("memo");
		String file = (String) multi.getFilesystemName("file");
		int file_size = (int) (new File(savePath + "/" + file).length());
		
		try {
			TeacherDAO dao = new TeacherDAO();
			dao.classqabbs_edit(idx, title, memo, file, file_size);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		resp.sendRedirect("classqa_bbs.hb?page=1");
	}

}
