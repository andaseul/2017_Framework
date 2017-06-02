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

@WebServlet("/hb/class_management.hb")
public class ClassManagement extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		AdministrationDAO dao = new AdministrationDAO();
		ArrayList<ClassDTO> list = null;
		
		try {
			list = dao.selectAllClass();
			req.setAttribute("class_list", list);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		req.getRequestDispatcher("/admin_classmanagement.jsp").forward(req, resp);
		
	}
	
}
