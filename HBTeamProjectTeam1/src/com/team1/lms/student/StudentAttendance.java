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
import com.team1.student.dto.StudentAttendanceDTO;
import com.team1.student.dto.StudentDetailAttendanceDTO;
import com.team1.util.Hanbit_LMS_DAO;

@WebServlet("/hb/stu_attend.hb")
public class StudentAttendance extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		String class_code = (String) session.getAttribute("class_code");
		
		StudentDAO dao = new StudentDAO();
		StudentAttendanceDTO bean = null;
		StudentAttendanceDTO bean2 = null;
		ArrayList<StudentDetailAttendanceDTO> list = null;
		
		try {
			bean = dao.getClassInfo(class_code);
			bean2 = dao.getAttendanceInfo(id);
			bean2.setClass_title(bean.getClass_title());
			bean2.setStart_date(bean.getStart_date());
			bean2.setEnd_date(bean.getEnd_date());
			bean2.setFull_attend(bean.getFull_attend());
			
			list = dao.getDetailInfo(id);
			req.setAttribute("detail_attinfo", list);
			
			// 출석률 계산
			// 전체기간 = 실제출석 / 총기간 * 100
			double full_rate = (double) (bean2.getReal_attend() - (bean2.getLate()/3));
			full_rate = full_rate / bean2.getFull_attend() * 100.0;
			full_rate = Math.round(full_rate*100d)/100d;
			
			// 단위기간 = 단위기간내출석 / 단위기간 * 100
			int quater_att = dao.getQuaterAttinfo(id);
			int quater = dao.getQuaterAttCnt(class_code);
			
			System.out.println(quater_att);
			System.out.println(quater);
			
			double month_rate = (double) (quater_att / (quater*1.0)) * 100.0;
			month_rate = Math.round(month_rate*100d)/100d;
			
			bean2.setFull_attendance_rate(full_rate);
			bean2.setMonth_attendance_rate(month_rate);
			
			req.setAttribute("attend_info", bean2);
			
			ArrayList<Object> array = dao.getCurrAttendInfo(id);
			if(array.size() == 0) {
				Hanbit_LMS_DAO dao2 = new Hanbit_LMS_DAO();
				dao2.updateTodayAttendanceInfo(id, class_code);
				array = dao.getCurrAttendInfo(id);
			}
			req.setAttribute("curdate", array.get(0).toString());
			req.setAttribute("curtime", array.get(1).toString());
			req.setAttribute("state", array.get(2));
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/stu_attend.jsp").forward(req, resp);
		
	}
	
}
