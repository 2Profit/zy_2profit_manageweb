package com.zy.profit.web.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

import com.zy.org.entity.User;
import com.zy.profit.web.IndexController;

public class HttpUtils {

	public static User getUser(HttpServletRequest request){
		return (User) request.getSession().getAttribute(IndexController.USER_SESSION_INFO);
	}
	
	public static String getIP(HttpServletRequest request){
		return request.getRemoteAddr();
	}

	public static Integer getPageSize(HttpServletRequest request){
		String pageSize = request.getParameter("pageSize");
		if(StringUtils.isNotBlank(pageSize)){
			return Integer.parseInt(pageSize);
		}
		return 10;
	}
	
	public static Integer getCurrentPage(HttpServletRequest request){
		String currentPage = request.getParameter("currentPage");
		if(StringUtils.isNotBlank(currentPage)){
			return Integer.parseInt(currentPage);
		}
		return 1;
	}
	
}
