package com.team1.lms.student;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.student.dao.StudentDAO;

@WebServlet("/hb/stu_attend_rq.hb")
public class StudentAttendanceRQ extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		String id = (String)session.getAttribute("id");
		String class_code = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		String curtime = sdf.format(new Date());
		int latetime = Integer.parseInt(curtime.replaceAll(":", ""));
		
		int state = 1;							// 출석
		if(91000 < latetime) state = 2;			// 지각
		if(latetime > 175000) state = 0;	// 결석
			
		try {
			StudentDAO dao = new StudentDAO();
			dao.request_attendance(id, state);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		System.out.println("<stu_attend_rq.hb> ID:" + id +" 출석요청 완료");
		resp.sendRedirect("stu_attend.hb");
	}
	
}
