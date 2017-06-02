package com.hb.day01.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.hb.day01.model.SimpleDao;

public class ListController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		// TODO Auto-generated method stub
		  ModelAndView mav = new ModelAndView();
		  SimpleDao dao = new SimpleDao();
		  mav.addObject("alist",dao.selectAll());
	      mav.setViewName("list");
	      return mav;
		
	}

}
   