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
import com.team1.student.dto.StudentDetailAttendanceDTO;

@WebServlet("/hb/admin_attdatail.hb")
public class Administraion_AttendDetail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String id = (String) req.getParameter("stu_id");
		String name = (String) req.getParameter("name");
		
		AdministrationDAO dao = new AdministrationDAO();
		ArrayList<StudentDetailAttendanceDTO> list = null;
		
		try {
			list = dao.getStudentAttDetailInfo(id);
			req.setAttribute("stu_id", id);
			req.setAttribute("stu_name", name);
			req.setAttribute("detail_info", list);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		req.getRequestDispatcher("/admin_attend_detail.jsp").forward(req, resp);
	}
	
}
