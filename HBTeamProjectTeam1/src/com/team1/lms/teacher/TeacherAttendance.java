package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.admin.dao.TeacherDAO;
import com.team1.admin.dto.Admin_StudentAttendanceDTO;

@WebServlet("/hb/teacher_attend.hb")
public class TeacherAttendance extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    String curdate = sdf.format(new Date());
	    
	    HttpSession session = req.getSession();
	    String id = (String) session.getAttribute("id");
	    String class_code;
		
	    try {
	    	TeacherDAO dao = new TeacherDAO();
	    	class_code = dao.getClassCode(id);
	    	
//	    	ArrayList<String> stu_list = dao.getClassStudent(class_code);
//	    	ArrayList<String> att_stu_list = dao.getAttendStudent(class_code);
//	    	
//	    	for(int i=stu_list.size()-1; i>=0; i--) {
//	    		for(int j=0; j<att_stu_list.size(); j++) {
//	    			if(stu_list.get(i).equals(att_stu_list.get(j))) {
//	    				stu_list.remove(i);
//	    				break;
//	    			}
//	    		}
//	    	}
//	    	if(stu_list.size() != 0) dao.setAttendStuInfo(stu_list, class_code);
	    	
			ArrayList<Admin_StudentAttendanceDTO> list = dao.getAttendState(class_code, curdate);
			
			req.setCharacterEncoding("UTF-8");
		    req.setAttribute("curdate", curdate);
		    req.setAttribute("list", list);
		    req.getRequestDispatcher("/teacher_attend.jsp").forward(req, resp);
		    
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	    
	}
	
}
