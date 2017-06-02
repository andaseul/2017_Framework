package com.team1.main;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.util.HanbitUserInfoDTO;
import com.team1.util.Hanbit_LMS_DAO;

@WebServlet("/hb/mypage_edit.hb")
public class HanbitMyPageEdit extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		int hb_code = ((Integer)session.getAttribute("hb_code")).intValue();
		String table = null;
		
		Hanbit_LMS_DAO dao = new Hanbit_LMS_DAO();
		
		// 切积老 版快
		if(hb_code == 1) table = "student";
		// 流盔老 版快
		else table = "employee";
		
		try {
			HanbitUserInfoDTO bean = dao.getUserinfo(id, table);
			req.setAttribute("bean", bean);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/mypage_edit.jsp").forward(req, resp);
		
	}
	
}
