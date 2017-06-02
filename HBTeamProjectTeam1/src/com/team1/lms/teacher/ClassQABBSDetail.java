package com.team1.lms.teacher;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.TeacherDAO;
import com.team1.admin.dto.ClassQABBSDTO;

@WebServlet("/hb/classqa_detail.hb")
public class ClassQABBSDetail extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		int hit = Integer.parseInt(req.getParameter("hit"));

		try {
			TeacherDAO dao = new TeacherDAO();
			dao.classqabbs_hit_count(idx, hit+1);
			ClassQABBSDTO bean = dao.classqabbs_detail(idx);
			int flag = 9;
			if(bean.getFile() != null) flag = badFileExtIsReturnBoolean(bean.getFile());
			
			req.setAttribute("img", flag);
			req.setAttribute("bean", bean);
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/classqa_detail.jsp").forward(req, resp);
	}

	public int badFileExtIsReturnBoolean(String fileName) {
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1,
                fileName.length());
        final String[] BAD_EXTENSION = { "jpg", "png", "jpeg", "gif" };
 
        int len = BAD_EXTENSION.length;
        for (int i = 0; i < len; i++) {
            if (ext.equalsIgnoreCase(BAD_EXTENSION[i])) {
                return 1; // 불량 확장자가 존재할때..
            }
        }
        return 0;
    }
	
}
