package com.zy.profit.web.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import org.apache.commons.io.FileUtils;

import com.zy.common.util.DateUtils;

public class FileUploadUtil {

	/**
	 * 禁止上传的文件类型
	 */
	public static final Set<String> denyFileExtSet = new HashSet<String>();
	
	static {
		denyFileExtSet.add(".exe");
		denyFileExtSet.add(".bat");
		denyFileExtSet.add(".sh");
		denyFileExtSet.add(".jsp");
		denyFileExtSet.add(".asp");
		denyFileExtSet.add(".php");
		denyFileExtSet.add(".js");
	}

	public static void judgeExt(String fileName) throws Exception {
		String ext = getExt(fileName);
		if(denyFileExtSet.contains(ext)){
			throw new Exception("此文件：" + fileName + " 是不被允许上传的，如果要上传请压缩后再上传!");
		}
	}
	
	public static String getExt(String fileName){
		if(fileName.lastIndexOf(".") == -1){
			return "";
		}
		return fileName.substring(fileName.lastIndexOf("."));
	}
	
	/**
	 * 上传附件
	 * @param is
	 * @return
	 * @throws UtilException 
	 * @throws IOException 
	 */
	public static String uploadAttachment(InputStream is, String fileName) throws Exception, IOException{
		
		judgeExt(fileName);
		
		String[] dates = DateUtils.dfDate.format(new Date()).split("-");
		
		String path = SystemConfig.getAttachmentPath() + File.separator + dates[0] 
				+ File.separator + dates[1] + File.separator + dates[2];
		
		String ext = getExt(fileName);
		
		String fName = UUID.randomUUID() + ext;
		
		String rootPath = SystemConfig.getWebRoot();
		
		File fileParent = new File(rootPath + path);
		if(!fileParent.exists()){
			fileParent.mkdirs();
		}
		
		File file = new File(fileParent, fName);
		
		FileUtils.copyInputStreamToFile(is, file);
		
		return path + File.separator + fName;
	}
	
}
