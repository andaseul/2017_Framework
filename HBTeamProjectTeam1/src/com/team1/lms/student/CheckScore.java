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
import com.team1.student.dto.ScoreDTO;

@WebServlet("/hb/check_score.hb")
public class CheckScore extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		
		StudentDAO dao = new StudentDAO();
		try {
			ArrayList<ScoreDTO> list = dao.getScoreInfo(id);
			for(int i=0; i<list.size(); i++) {
				list.get(i).setTitle(dao.getTitle(list.get(i).getSub_code()));
			}
			req.setAttribute("score_list", list);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/check_score.jsp").forward(req, resp);
	}
	
}
