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
		//��ü ������/������� ������ �̾ƿ��� �������� Ŭ�������� ���� �̾ƿͼ� ��Ʈ ���� �̾ƿ���
		//list[0] ��ü ������ [1] ���0 [2]���X  [3] �� Ŭ���� ����
		//list2[][] ���0 ���x �迭�� Ŭ���� ���� ��ŭ �޾ƿ�
		//�� ��������, �� ������, �� ��������� , �� Ŭ���� ���� =�� �迭 4
		
		//list[3] �� �޾ƿ� ��Ʈ ������ for�� ������ Ŭ������ ��������� ������ �̾ƿ���
		// ���� �迭�� ����
		
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
		// ��ü Ȯ��
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
				
				// ����� ���
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
