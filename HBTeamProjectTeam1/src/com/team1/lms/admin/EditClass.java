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

@WebServlet("/hb/class_edit.hb")
public class EditClass extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String class_code = (String) req.getParameter("code");
		
		AdministrationDAO dao = new AdministrationDAO();
		ClassDTO bean = new ClassDTO();
		ArrayList<String> teacher_list = null;
		try {
			bean = dao.getClassInfo(class_code);
			teacher_list = dao.getTeacherName();
			req.setAttribute("class_info", bean);
			req.setAttribute("teacher_list", teacher_list);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/admin_classedit.jsp").forward(req, resp);
	}
	
}
