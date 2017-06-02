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
		
		 // ① 파일명 가져오기
        String fileName = req.getParameter("filename");
        
        // ② 경로 가져오기
        String saveDir =req.getRealPath("/upload/recruit").replaceAll("\\\\", "/");
        File file = new File(saveDir + "/" + fileName);
        System.out.println("파일명 : " + fileName);
        
        
        // ③ MIMETYPE 설정하기
        String mimeType = getServletContext().getMimeType(file.toString());
        if(mimeType == null)
        {
           resp.setContentType("application/octet-stream");
        }
        
        // ④ 다운로드용 파일명을 설정
        String downName = null;
        if(req.getHeader("user-agent").indexOf("MSIE") == -1)
        {
           downName = new String(fileName.getBytes("UTF-8"), "8859_1");
        }
        else
        {
           downName = new String(fileName.getBytes("EUC-KR"), "8859_1");
        }
        
        // ⑤ 무조건 다운로드하도록 설정
        resp.setHeader("Content-Disposition","attachment;filename=\"" + downName + "\";");
        
        // ⑥ 요청된 파일을 읽어서 클라이언트쪽으로 저장한다.
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
