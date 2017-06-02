package com.team1.lms.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.AdministrationDAO;
import com.team1.admin.dto.EmployeeDTO;

@WebServlet("/hb/insert_staff.hb")
public class InsertStaffDB extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		EmployeeDTO bean = new EmployeeDTO();
		bean.setId((String)req.getParameter("id"));
		bean.setPw((String)req.getParameter("pw"));
		bean.setName((String)req.getParameter("name"));
		bean.setGender((String)req.getParameter("chk_gender"));
		bean.setBirthday((String)req.getParameter("birthday"));
		bean.setAddress((String)req.getParameter("address"));
		bean.setMail((String)req.getParameter("mail"));
		bean.setStaff_code(Integer.parseInt((String)req.getParameter("chk_team")));
		bean.setAccount_name((String)req.getParameter("account_name"));
		bean.setAccount((String)req.getParameter("account"));
		bean.setJoindate((String)req.getParameter("joindate"));
		bean.setPhone((String)req.getParameter("phone"));
		
		AdministrationDAO dao = new AdministrationDAO();
		int result = 0, result2 = 0;
		try {
			result = dao.insertStaff(bean);			// 직원등록
			
			if(result > 0) {
				result2 = dao.insertTeam(bean);		// 소속(팀)등록
				if(result2 > 0) resp.sendRedirect("staff_management.hb");
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
