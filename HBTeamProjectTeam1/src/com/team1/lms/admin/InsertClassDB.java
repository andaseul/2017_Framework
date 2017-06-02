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
import com.team1.admin.dto.ClassDTO;
import com.team1.admin.dto.SubjectDTO;

@WebServlet("/hb/insert_class.hb")
public class InsertClassDB extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String start_date = (String)req.getParameter("start_date");
		String end_date = (String)req.getParameter("end_date");
		
		ClassDTO bean = new ClassDTO();
		bean.setCode((String)req.getParameter("class_code"));
		
		String title = (String)req.getParameter("title");
		String[] sub_title = new String [3]; 
		if(title.equals("class1")) {
			bean.setTitle("UI/UX를 기반으로 한 스마트 웹 앱콘텐츠 개발자 과정");
			sub_title[0] ="Java & Oracle";
			sub_title[1] ="JavaScript & JQuery";
			sub_title[2] ="Spring Framwork";
		}
		else if(title.equals("class2")) {
			bean.setTitle("빅데이터 분석 및 응용SW엔지니어링 양성 과정");
			sub_title[0] ="R프로그래밍";
			sub_title[1] ="데이터마이닝 이론과 실습";
			sub_title[2] ="HTML & JavasScript 웹데이터 크롤링";
		}
		else if(title.equals("class3")) {
			bean.setTitle("Interactive Web Design을 위한 Web Publisher 양성 과정");
			sub_title[0] ="Java";
			sub_title[1] ="HTML5 & CSS";
			sub_title[2] ="JavaScript & JQuery";
		}
		
		bean.setTeacher_name((String)req.getParameter("name"));
		bean.setStart_date(start_date);
		bean.setEnd_date(end_date);
		
		AdministrationDAO dao = new AdministrationDAO();
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<Integer> list2 = new ArrayList<Integer>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
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
			
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		bean.setAttendance_day(list.size());
		
		int result = 0, result2 = 0;
		try {
			result = dao.insertClass(bean);
			
			// 과목정보 등록
			for(int i=0; i<3; i++) {
				String sub_code = bean.getCode()+"-"+(i+1);
				dao.insertSubject(bean.getCode(), sub_code, sub_title[i]);
			}
			
			// 해당강의 출석정보
			dao.updateClassAttInfo(bean.getCode(), list, list2);
			
			if(result > 0) {
				result2 = dao.updateTeacherClass(bean.getCode(), bean.getTeacher_name());
				if(result2 > 0)	resp.sendRedirect("class_management.hb");
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(result <= 0 || result2 <= 0) {
			resp.setContentType("text/html; charset=UTF-8");
			resp.setCharacterEncoding("UTF-8");
			String msg = "<script type=\"text/javascript\">";
			msg += "window.history.back();";
			msg += "</script>";
			resp.getWriter().print(msg);
			return;
		}
	}
	
}
