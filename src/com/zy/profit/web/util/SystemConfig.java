package com.zy.profit.web.util;

import java.io.IOException;
import java.util.Properties;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PropertiesLoaderUtils;

/**
 * 
 * @author LL
 *
 */
public class SystemConfig {

	private static Properties properties = null;
	
	static{
		try {
			properties = PropertiesLoaderUtils.loadProperties(new ClassPathResource("config.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 项目的物理路径 
	 * @return
	 */
	public static String getWebRoot(){
		return System.getProperty("2profit.root");
	}
	
	/**
	 * 临时文件路径
	 * @return
	 */
	public static String getTmpPath(){
		return properties.getProperty("tmp");
	}
	
	/**
	 * 附件存放路径
	 * @return
	 */
	public static String getAttachmentPath(){
		return properties.getProperty("attachment");
	}
	
}
