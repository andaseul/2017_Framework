package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.admin.dao.AdministrationDAO;
import com.team1.admin.dao.TeacherDAO;
import com.team1.admin.dto.ClassNoticeDTO;
import com.team1.admin.dto.PageDTO;

@WebServlet("/hb/classnotice_bbs.hb")
public class ClassNoticeBBS extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String class_code = (String) session.getAttribute("class_code");
		
		int page = Integer.parseInt(req.getParameter("page"));
		int cnt = 0;
		PageDTO dto = null; 
		
		TeacherDAO dao = new TeacherDAO();
		List<ClassNoticeDTO> list = null;
		try {
			list = dao.classbbs_list(class_code, page);
			cnt = dao.countall("classnotice_bbs", class_code);
			dto = dao.page_detail(page, cnt);
		} catch (SQLException e){
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		};
		req.setAttribute("alist", list);
		req.setAttribute("page_detail", dto);
		req.getRequestDispatcher("/classnotice_bbs.jsp").forward(req, resp);
	}
	
}
