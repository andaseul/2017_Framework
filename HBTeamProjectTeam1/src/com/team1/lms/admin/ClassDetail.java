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
import com.team1.admin.dto.ClassDTO;
import com.team1.admin.dto.ClassStudentDTO;

@WebServlet("/hb/detail_class.hb")
public class ClassDetail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String class_code = (String) req.getParameter("code");
		
		AdministrationDAO dao = new AdministrationDAO();
		ClassDTO bean = new ClassDTO();
		ArrayList<ClassStudentDTO> list = null;
		
		try {
			bean = dao.getClassInfo(class_code);
			list = dao.getClassStudentInfo(class_code);
			req.setAttribute("class_info", bean);
			req.setAttribute("class_stu", list);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/admin_classdetail.jsp").forward(req, resp);
		
	}
	
}
