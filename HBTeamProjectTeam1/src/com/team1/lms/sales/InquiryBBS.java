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
import com.team1.admin.dto.InquiryDTO;
import com.team1.admin.dto.PageDTO;

@WebServlet("/hb/inquiry_bbs.hb")
public class InquiryBBS extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		int page = Integer.parseInt(req.getParameter("page"));
		int cnt = 0;
		
		SalesDAO dao = new SalesDAO();
		ArrayList<InquiryDTO> list = null;
		PageDTO dto = null; 
		try {
			list = dao.inquiry_list(page);
			cnt = dao.countall();
			dto = dao.page_detail(page, cnt);
		} catch (SQLException e){
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		};
		req.setAttribute("alist", list);
		req.setAttribute("page_detail", dto);
		req.getRequestDispatcher("/inquiry_bbs.jsp").forward(req, resp);
	}
	
}
