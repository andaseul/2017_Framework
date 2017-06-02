package com.team1.main;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.util.Hanbit_LMS_DAO;

@WebServlet("/hb/mypage_update.hb")
public class HanbitMyPageUpdate extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		int hb_code = ((Integer)session.getAttribute("hb_code")).intValue();
		String id = (String) req.getParameter("id");
		String pw = (String) req.getParameter("pw");
		String name = (String) req.getParameter("name");
		String birthday = (String) req.getParameter("birthday");
		String mail = (String) req.getParameter("mail");
		String address = (String) req.getParameter("address");
		String phone = (String) req.getParameter("phone");
		String table = null;
		
		Hanbit_LMS_DAO dao = new Hanbit_LMS_DAO();
		if(hb_code == 1) table="student";
		else table = "employee";
		
		int result = 0;
		
		try {
			result = dao.updateUserInfo(table, id, pw, name, birthday, mail, address, phone);
			session.setAttribute("name", name);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		if(result > 0) {
			resp.sendRedirect("mypage.hb");
		}
	}
	
}
