package com.team1.lms.student;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.student.dao.StudentDAO;
import com.team1.student.dto.OnlineTestDTO;

@WebServlet("/hb/start_exam.hb")
public class StartExam extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String sub_code = (String) req.getParameter("sub_code");
		String title = (String) req.getParameter("title");
		
		StudentDAO dao = new StudentDAO();
		try {
			ArrayList<OnlineTestDTO> list = dao.getQuestionList(sub_code);
			req.setAttribute("qlist", list);
			req.setAttribute("sub_code", sub_code);
			req.setAttribute("title", title);
			req.setAttribute("qcnt", list.size());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/start_exam.jsp").forward(req, resp);
	}
	
}
