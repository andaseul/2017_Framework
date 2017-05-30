package com.hb.action;

import com.hb.model.SimpleDao;
import com.opensymphony.xwork2.ActionSupport;

public class SelectOne extends ActionSupport {

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		private int sabun;
		private Map<String, Object> bean;
		
		public void setSabun(int sabun){
			
		}
		
		
		
		SimpleDao dao = new SimpleDao();
		return this.SUCCESS;
	}
}
