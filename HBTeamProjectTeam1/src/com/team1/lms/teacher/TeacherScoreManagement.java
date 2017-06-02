package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.admin.dao.TeacherDAO;
import com.team1.admin.dto.SubjectDTO;

@WebServlet("/hb/score_management.hb")
public class TeacherScoreManagement extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		
		TeacherDAO dao = new TeacherDAO();
		String class_code = null;
		try {
			class_code = dao.getClassCode(id);
			ArrayList<SubjectDTO> list = dao.getSubjectInfo(class_code);
			req.setAttribute("sub_list", list);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/score_management.jsp").forward(req, resp);
	}
	
}
