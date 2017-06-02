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
import com.team1.admin.dto.ClassQABBSDTO;
import com.team1.admin.dto.PageDTO;

@WebServlet("/hb/classqa_bbs.hb")
public class ClassQABBS extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		TeacherDAO dao = new TeacherDAO();
		HttpSession session = req.getSession();
		String class_code = (String) session.getAttribute("class_code");
		
		System.out.println(class_code);
		
		int page = Integer.parseInt(req.getParameter("page"));
		int cnt = 0;
		PageDTO dto = null; 
		
		List<ClassQABBSDTO> list = null;

		try {
			list = dao.classqabbs_list(class_code, page);
			cnt = dao.countall("classqabbs", class_code);
			dto = dao.page_detail(page, cnt);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.setAttribute("alist", list);
		req.setAttribute("page_detail", dto);
		req.getRequestDispatcher("/classqa_bbs.jsp").forward(req, resp);
	}

}
