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

@WebServlet("/hb/add_class.hb")
public class AddClass extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
				
		req.setCharacterEncoding("UTF-8");
		AdministrationDAO dao = new AdministrationDAO();
		ArrayList<String> teacher_list = null;
		
		try {
			teacher_list = dao.getTeacherName();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		req.setAttribute("teacher_list", teacher_list);
		req.getRequestDispatcher("/add_class.jsp").forward(req, resp);
		
	}
	
}
