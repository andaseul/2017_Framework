package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/classwrite_data.hb")
public class ClassNoticeWriteData extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		HttpSession session = req.getSession();
		String class_code = (String) session.getAttribute("class_code");
		System.out.println(class_code);
		
		String title = (String) req.getParameter("title");
		String username = "강의 공지맨";
		String memo = (String) req.getParameter("memo");
		
		int result = 0;
		
		try {
			TeacherDAO dao = new TeacherDAO();
			result = dao.insert_classbbs_data(title, username, memo, class_code);
		} catch (SQLException | ClassNotFoundException e){
			e.printStackTrace();
			
		}
		
		if(result > 0) {
			resp.sendRedirect("classnotice_bbs.hb?page=1");
		}	
	}
	
}
