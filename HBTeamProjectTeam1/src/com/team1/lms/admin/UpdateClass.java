package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;

@WebServlet("/hb/class_update.hb")
public class UpdateClass extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String class_code = (String) req.getParameter("code");
		String title = (String) req.getParameter("title");
		String teacher = (String) req.getParameter("teacher");
		int limit = Integer.parseInt((String) req.getParameter("limit"));
		String start_date = (String) req.getParameter("start_date");
		String end_date = (String) req.getParameter("end_date");
		int result = 0;
		
		AdministrationDAO dao = new AdministrationDAO();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<Integer> list2 = new ArrayList<Integer>();
		Calendar cal = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		Date start=null, end=null;
		
		try {
			start = sdf.parse(start_date);
			end = sdf.parse(end_date);
		
			cal.setTime(start);
			cal2.setTime(end);
		
			// 토요일=6, 일요일=7
			int week_cnt = 0;
			
			while(true) {
				if(((cal2.getTime()).getTime() - (cal.getTime()).getTime()) / (24 * 60 * 60 * 1000) <= 0) break;
				if(cal.get(Calendar.DAY_OF_WEEK)==6) week_cnt++;
				else if(cal.get(Calendar.DAY_OF_WEEK)==7) week_cnt++;
				else {
					Date tomorrow = cal.getTime();
					int month = tomorrow.getMonth() + 1;
					list.add(sdf.format(tomorrow));
					list2.add(month);
				}
				cal.add(Calendar.DAY_OF_YEAR, 1);	// 하루증가
			}
			
			Date tomorrow = cal.getTime();
			int month = tomorrow.getMonth() + 1;
			list.add(sdf.format(tomorrow));
			list2.add(month);
			
			dao.updateClassAttInfo(class_code, list, list2);
			result = dao.updateClassInfo(class_code, title, teacher, limit, start_date, end_date, list.size());
			
		} catch (ParseException | ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		if(result > 0) {
			resp.sendRedirect("detail_class.hb?code="+class_code);
		}
		
	}
	
}
