package com.team1.lms.sales;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.SalesDAO;
import com.team1.admin.dto.RealAttendanceListDTO;

@WebServlet("/hb/applicant_approve.hb")
public class ApplicantApprove extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String id = (String) req.getParameter("id");
		String name = (String) req.getParameter("name");
		String class_code = (String) req.getParameter("class_code");
		
		SalesDAO dao = new SalesDAO();
		int result = 0;
		try {
			// 신청자 lms 회원 승인
			dao.updateClassCurNum(class_code);
			result = dao.approveApplicant(id);
			
			// 출석정보 업데이트
			ArrayList<RealAttendanceListDTO> list = dao.getAttInfo(class_code);
			dao.insertAttinfo(id, list);
			
			// 취업정보 업데이트
			result = dao.insertStudentJob(id, name);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		if(result > 0) {
			resp.sendRedirect("applicant_management.hb");
		}
	}
	
}
