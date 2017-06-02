package com.team1.lms.jobsupport;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hb/recruitinfo_down.hb")
public class RecruitInfoBBSFileDown extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		 // �� ���ϸ� ��������
        String fileName = req.getParameter("filename");
        
        // �� ��� ��������
        String saveDir =req.getRealPath("/upload/recruit").replaceAll("\\\\", "/");
        File file = new File(saveDir + "/" + fileName);
        System.out.println("���ϸ� : " + fileName);
        
        
        // �� MIMETYPE �����ϱ�
        String mimeType = getServletContext().getMimeType(file.toString());
        if(mimeType == null)
        {
           resp.setContentType("application/octet-stream");
        }
        
        // �� �ٿ�ε�� ���ϸ��� ����
        String downName = null;
        if(req.getHeader("user-agent").indexOf("MSIE") == -1)
        {
           downName = new String(fileName.getBytes("UTF-8"), "8859_1");
        }
        else
        {
           downName = new String(fileName.getBytes("EUC-KR"), "8859_1");
        }
        
        // �� ������ �ٿ�ε��ϵ��� ����
        resp.setHeader("Content-Disposition","attachment;filename=\"" + downName + "\";");
        
        // �� ��û�� ������ �о Ŭ���̾�Ʈ������ �����Ѵ�.
        FileInputStream fileInputStream = new FileInputStream(file);
        ServletOutputStream servletOutputStream = resp.getOutputStream();
        
        byte b [] = new byte[1024];
        int data = 0;
        
        while((data=(fileInputStream.read(b, 0, b.length))) != -1)
        {
           servletOutputStream.write(b, 0, data);
        }
        
        servletOutputStream.flush();
        servletOutputStream.close();
        fileInputStream.close();

	}
	
}
