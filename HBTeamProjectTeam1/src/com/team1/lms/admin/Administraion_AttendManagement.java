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
import com.team1.admin.dto.Admin_StudentAttListDTO;
import com.team1.admin.dto.PageDTO;

@WebServlet("/hb/admin_att.hb")
public class Administraion_AttendManagement extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int page = Integer.parseInt(req.getParameter("page"));
		int cnt = 0;
		
		PageDTO dto = null; 
		AdministrationDAO dao = new AdministrationDAO();
		ArrayList<Admin_StudentAttListDTO> list = null;
		
		String keyword = (String) req.getParameter("keyword");
		String search = (String) req.getParameter("sel");
		
		try {
			if(keyword != null || search != null) {
				if(!search.equals("search")) list = dao.getStudentAttendInfo(page, search, keyword);
				else list = dao.getStudentAttendInfo(page);
			} else {
				list = dao.getStudentAttendInfo(page);
			}
			cnt = dao.st_countall();
			dto = dao.page_detail(page, cnt);
			
			req.setAttribute("page_detail", dto);
			req.setAttribute("st_att_list", list);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		req.getRequestDispatcher("/admin_attend.jsp").forward(req, resp);
	}
	
}
