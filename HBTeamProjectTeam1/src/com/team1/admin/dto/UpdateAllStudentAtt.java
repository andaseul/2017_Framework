package com.team1.admin.dto;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;

@WebServlet("/hb/update_att.hb")
public class UpdateAllStudentAtt extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int stu_num = Integer.parseInt((String) req.getParameter("stu_num"));
		String[] id = new String[stu_num];
		int[] state = new int[stu_num];
		
		TeacherDAO dao = new TeacherDAO();
		
		for(int i=0; i<stu_num; i++) {
			id[i] = (String) req.getParameter("id"+i);
			String str_state = (String) req.getParameter("state"+i);
			if(str_state.equals("출석")) state[i] = 1;
			else if(str_state.equals("지각")) state[i] = 2;
			else if(str_state.equals("조퇴")) state[i] = 3;
			else if(str_state.equals("결석")) state[i] = 0;
			
			try {
				dao.updateStudentAttInfo(id[i], state[i]);
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
		}
		resp.sendRedirect("teacher_attend.hb");
	}
	
}
