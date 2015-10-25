package com.zy.profit.web.util;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

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
	
	/**
	 * 下载文件
	 * @param fileName
	 * @param fileUrl
	 * @return
	 */
	public static ResponseEntity<byte[]> download(String fileName, String fileUrl){
        File file = new File(fileUrl);  
        HttpHeaders headers = new HttpHeaders();    
        ResponseEntity<byte[]> re = null;
		try {
			String fn = new String(fileName.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
			headers.setContentDispositionFormData("attachment", fn);
	        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	        re = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
                    headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
		}
           
        return re;
	}
	
	
}
