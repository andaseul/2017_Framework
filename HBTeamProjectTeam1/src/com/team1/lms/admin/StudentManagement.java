package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;
import com.team1.admin.dto.PageDTO;
import com.team1.admin.dto.StudentInfoDTO;

@WebServlet("/hb/student_management.hb")
public class StudentManagement extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int page = Integer.parseInt(req.getParameter("page"));
		int cnt = 0;
		
		PageDTO dto = null; 
		AdministrationDAO dao = new AdministrationDAO();
		ArrayList<StudentInfoDTO> list = new ArrayList<StudentInfoDTO>();
		
		String keyword = (String) req.getParameter("keyword");
		String search = (String) req.getParameter("sel");
		
		try {
			if(keyword != null || search != null) {
				if(!search.equals("search")) list = dao.getStudentInfo(page, search, keyword);
				else list = dao.getStudentInfo(page);
			} else {
				list = dao.getStudentInfo(page);
			}
			cnt = dao.st_countall();
			dto = dao.page_detail(page, cnt);
			
			req.setAttribute("list", list);
			req.setAttribute("page_detail", dto);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		req.getRequestDispatcher("/admin_studentmanagement.jsp").forward(req, resp);
		
	}
	
}
