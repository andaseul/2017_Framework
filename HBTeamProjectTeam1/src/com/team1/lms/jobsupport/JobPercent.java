package com.team1.lms.jobsupport;

import java.awt.List;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team1.admin.dao.JobSupportDAO;
import com.team1.admin.dto.ClassJobDTO;

/**
 * Servlet implementation class job_percent
 */
@WebServlet(name = "job_percent.hb", urlPatterns = { "/hb/job_percent.hb" })
public class JobPercent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//전체 구직자/취업성공 데이터 뽑아오기 동적으로 클래스에서 갯수 뽑아와서 차트 생성 뽑아오기
		//list[0] 전체 구직자 [1] 취업0 [2]취업X  [3] 총 클래스 갯수
		//list2[][] 취업0 취업x 배열로 클래수 개수 만큼 받아옴
		//총 수강생명, 총 구직자, 총 취업성공자 , 총 클래스 개수 =총 배열 4
		
		//list[3] 에 받아온 인트 값으로 for문 돌려서 클래스별 취업성공자 구직자 뽑아오기
		// 다중 배열로 받음
		
		int all =0, succ=0, fail=0;
		
		ArrayList<String> class_list = new ArrayList<String>();
		ArrayList<ClassJobDTO> list = new ArrayList<ClassJobDTO>();
		ClassJobDTO bean = new ClassJobDTO();
		
		JobSupportDAO dao = new JobSupportDAO();
		all = dao.countall("student where approve=1");
		succ = dao.count_jobsuccess();
		fail = all - succ;
		
		double job_suc_rate = dao.job_percent(all, succ, fail);
		double job_fail_rate = 100 - job_suc_rate;
		
		System.out.println(job_suc_rate);
		System.out.println(job_fail_rate);
		// 전체 확률
		bean.setClass_code("all");
		bean.setJob_suc(job_suc_rate);
		bean.setJob_fail(job_fail_rate);
		list.add(bean);
		
		try {
			class_list = dao.getClassCode();
			for(int i=0; i<class_list.size(); i++) {
				ClassJobDTO bean2 = new ClassJobDTO();
				all = dao.countall("student", class_list.get(i));
				succ = dao.count_jobsuccess(class_list.get(i));
				fail = all - succ;
				
				// 취업률 계산
				job_suc_rate = dao.job_percent(all, succ, fail);
				job_fail_rate = 100 - job_suc_rate;
				
				bean2.setClass_code(class_list.get(i));
				bean2.setJob_suc(job_suc_rate);
				bean2.setJob_fail(job_fail_rate);
				list.add(bean2);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i).getClass_code());
			System.out.println(list.get(i).getJob_suc());
		}
		
		request.setAttribute("list", list);
		request.getRequestDispatcher("/job_percent.jsp").forward(request, response);

	}

}
