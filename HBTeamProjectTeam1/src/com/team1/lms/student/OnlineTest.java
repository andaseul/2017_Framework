package com.team1.lms.student;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.student.dao.StudentDAO;
import com.team1.student.dto.ExamListDTO;

@WebServlet("/hb/online_test.hb")
public class OnlineTest extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		String class_code = null;
		
		StudentDAO dao = new StudentDAO();
		try {
			class_code = dao.stu_getClassCode(id);
			ArrayList<ExamListDTO> list = dao.getOnlineTest(class_code);
			for(int i=0; i<list.size(); i++) {
				list.get(i).setInfo(dao.getSubmitExamInfo(id, list.get(i).getSub_code()));
			}
			req.setAttribute("test_list", list);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		req.getRequestDispatcher("/stu_onlinetest.jsp").forward(req, resp);
	}
	
}
