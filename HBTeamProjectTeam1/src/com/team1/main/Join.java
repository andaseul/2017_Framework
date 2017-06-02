package com.team1.main;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.util.Hanbit_LMS_DAO;

@WebServlet("/hb/StuJoin.hb")
public class Join extends HttpServlet{

		@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp)
				throws ServletException, IOException {
			
			req.setCharacterEncoding("UTF-8");
			String id = (String) req.getParameter("id");
			String pw = (String) req.getParameter("pw");
			String name = (String) req.getParameter("name");
			String gender = (String) req.getParameter("gender");
			String subTitle = (String) req.getParameter("subTitle");
			String address = (String) req.getParameter("address");
			String email = (String) req.getParameter("email");
			String birth = (String) req.getParameter("birth");
			String phone = (String) req.getParameter("phone");
			int result = 0;
			
			Hanbit_LMS_DAO dao = new Hanbit_LMS_DAO();
			try {
				result = dao.insertStudent(id, pw, name, gender, subTitle, address, email, birth, phone);
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
			
			if(result > 0) {
				resp.setContentType("text/html; charset=UTF-8");
	            resp.setCharacterEncoding("UTF-8");
	            String msg = "<script type=\"text/javascript\">";
	            msg += "alert(\"수강신청이 완료되었습니다.\");";
	            msg += "</script>";
	            resp.getWriter().print(msg);
	            resp.sendRedirect("hanbit.hb");
			}
			
		}
		
}
