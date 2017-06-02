package com.team1.main;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.util.HanbitClassNoticeDTO;
import com.team1.util.HanbitNoticeDTO;
import com.team1.util.HanbitUserDTO;
import com.team1.util.Hanbit_LMS_DAO;

@WebServlet("/hb/lms_main.hb")
public class HanbitLogin extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		int hb_code = ((Integer)session.getAttribute("hb_code")).intValue();
		
		Hanbit_LMS_DAO dao = new Hanbit_LMS_DAO();
		try {
			ArrayList<HanbitNoticeDTO> list = dao.getNoticeInfo();
			req.setAttribute("notice_info", list);
			
			if(hb_code==1 || hb_code==3) {
				String class_code = (String) session.getAttribute("class_code");
				
				ArrayList<HanbitClassNoticeDTO> list2 = dao.getClassNoticeInfo(class_code);
				req.setAttribute("class_notice_info", list2);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		if(id != null) {
			req.getRequestDispatcher("/lms_main.jsp").forward(req, resp);
		} else {
			resp.sendRedirect("main.hb");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String[] params = new String[3]; 
		params[0] = req.getParameter("id").trim();
		params[1] = req.getParameter("pw").trim();
		params[2] = req.getParameter("chk_info").trim();
		
		String id = params[0];
		String pw = params[1];
		String user_code = params[2];
		
		// 0. ��ȸ��, 1. �л�, 2. ����, 3. ����
		int hb_code = 0;
		Hanbit_LMS_DAO dao = new Hanbit_LMS_DAO();
		
		try {
			
			// �α��� ����
			if((hb_code = dao.login(id, pw, user_code)) != 0) {
				HanbitUserDTO bean = dao.getUserInfo(user_code, id);
				HttpSession session = req.getSession();
				session.setAttribute("id", id);
				session.setAttribute("hb_code", hb_code);
				session.setAttribute("name", bean.getName());
				session.setAttribute("gender", bean.getGender());
				
				// �������� �ҷ�����
				HanbitNoticeDTO bean2;
				ArrayList<HanbitNoticeDTO> list = dao.getNoticeInfo();
				req.setAttribute("notice_info", list);
				
				String class_code = null;
				
				// �л�, ������ ��� Ŭ�����ڵ� ���ǵ�� & ���ǰ��� �ҷ�����
				if(hb_code==1 || hb_code==3) {
					class_code = dao.getClassCode(hb_code, id);
					session.setAttribute("class_code", class_code);
					
					ArrayList<HanbitClassNoticeDTO> list2 = dao.getClassNoticeInfo(class_code);
					req.setAttribute("class_notice_info", list2);
				}
				
				System.out.println("�α��� ����\n<login.hb> hb_code : " + hb_code);
				req.getRequestDispatcher("/lms_main.jsp").forward(req, resp);
			}
			// �α��� ����
			else {
				System.out.println("�α��� ����");
				resp.setContentType("text/html; charset=UTF-8");
				resp.setCharacterEncoding("UTF-8");
				String msg = "<script type=\"text/javascript\">";
				msg += "alert(\"ID Ȥ�� Password�� Ȯ���ϼ���\");";
				msg += "window.history.back();";
				msg += "</script>";
				resp.getWriter().print(msg);
				return;
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
}
