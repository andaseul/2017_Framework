package com.team1.lms.student;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team1.student.dao.StudentDAO;

@WebServlet("/hb/submit_exam.hb")
public class SubmitExam extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		String id = (String) session.getAttribute("id");
		String sub_code = (String) req.getParameter("sub_code");
		int qcnt = Integer.parseInt((String) req.getParameter("qcnt").trim());
		int result = 0;
		
		String[] qcode = new String[qcnt];
		int[] answer = new int[qcnt];
		
		StudentDAO dao = new StudentDAO();
		
		for(int i=0; i<qcnt; i++) {
			// 문제코드
			qcode[i] = (String) req.getParameter("qcode"+i);
			// 제출한 답
			String temp = (String) req.getParameter("answer"+i);
			if(temp == null) answer[i] = 0;
			else if(temp.equals("ex1")) answer[i] = 1;
			else if(temp.equals("ex2")) answer[i] = 2;
			else if(temp.equals("ex3")) answer[i] = 3;
			else if(temp.equals("ex4")) answer[i] = 4;
			else if(temp.equals("ex5")) answer[i] = 5;
			else answer[i] = 0;
			
			try {
				// 제출한 답안 테이블 저장
				result = dao.submitExamAnswer(id, qcode[i], sub_code, answer[i]);	
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
		}
		
		// 답지 불러오기
		int[] exam_result = new int[qcnt];
		try {
			exam_result = dao.getExamAnswerList(sub_code, qcnt);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		// 점수 계산
		int total_score = qcnt * 10;
		int score = 0;
		for(int i=0; i<qcnt; i++) {
			if(exam_result[i] == answer[i]) score += 10;
		}
		
		// 점수 등록
		int result2 = 0;
		try {
			result2 = dao.insertScore(id, sub_code, score, total_score);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect("online_test.hb");
		
	}
	
}
