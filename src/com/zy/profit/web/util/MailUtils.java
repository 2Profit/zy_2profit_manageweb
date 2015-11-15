package com.zy.profit.web.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * 发送邮件
 * @author Administrator
 *
 */
public class MailUtils {

	private static Session session;

	private static final String SUBJECT = "至盈网";
	
//	private static final DateFormat DATE_FORMAT = new SimpleDateFormat("yyyy年MM月dd日");
	
	private static Map<Integer, String> modelMap = new HashMap<Integer, String>();
	
	private static final int TYPE_PASS_NO_REG = 0;
	private static final int TYPE_PASS_REG = 1;
	private static final int TYPE_CANCEL = 2;
	
	static {
		Properties props = new Properties();
		// 设置发送邮件的邮件服务器的属性（这里使用网易的smtp服务器）
		props.put("mail.smtp.host", SystemConfig.getMailSmtp());
		// 需要经过授权，也就是有户名和密码的校验，这样才能通过验证（一定要有这一条）
		props.put("mail.smtp.auth", "true");
		
		// 用刚刚设置好的props对象构建一个session
		session = Session.getDefaultInstance(props);
		// 有了这句便可以在发送邮件的过程中在console处显示过程信息，供调试使
		// 用（你可以在控制台（console)上看到发送邮件的过程）
//		session.setDebug(true);
		
		String webRoot = SystemConfig.getWebRoot();
		
		modelMap.put(TYPE_PASS_NO_REG, readTxt(webRoot + "/static/mail/type_pass_no_reg.txt"));
		modelMap.put(TYPE_PASS_REG, readTxt(webRoot + "/static/mail/type_pass_reg.txt"));
		modelMap.put(TYPE_CANCEL, readTxt(webRoot + "/static/mail/type_cancel.txt"));
		
	}

	private static String readTxt(String path){
		
		StringBuilder sb = new StringBuilder();
		
		//读取邮件模板文件
		LineNumberReader lineNumberReader = null;
		try {
			lineNumberReader = new LineNumberReader(new BufferedReader(new InputStreamReader(new FileInputStream(path), "utf-8")));
			String lineString; 
            while ((lineString = lineNumberReader.readLine()) != null) {
            	sb.append(lineString);
            }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(lineNumberReader != null){
				try {
					lineNumberReader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		String str = sb.toString();
		str = str.replaceAll("\\$\\{gatewebUrl\\}", SystemConfig.getGatewebUrl());
		
		return str;
	}
	
	/**
	 * 审核用过未注册
	 * @param email
	 * @return
	 */
	public static boolean sendTypePassNoReg(String email, String posBackDiscountId){
		
		String content = modelMap.get(MailUtils.TYPE_PASS_NO_REG);
		
		content = content.replaceAll("\\$\\{email\\}", email);
		
		String url = "";
		try {
			url = SystemConfig.getGatewebDiscountRegUrl() + URLEncoder.encode(posBackDiscountId, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		content = content.replaceAll("\\$\\{url\\}", url);
		
		return send(email, content, SUBJECT);
	}
	
	/**
	 * 审核通过已经注册
	 * @param email
	 * @return
	 */
	public static boolean sendTypePassReg(String email){
		
		String content = modelMap.get(MailUtils.TYPE_PASS_REG);
		
		return send(email, content, SUBJECT);
	}
	
	public static boolean sendTypeCancel(String email){
		
		String content = modelMap.get(MailUtils.TYPE_CANCEL);
		
		return send(email, content, SUBJECT);
	}
	
	/**
	 * 发送邮件
	 * @param to
	 * @param content
	 * @param subject
	 * @return
	 */
	public static boolean send(String to, String content, String subject){
		MimeMessage message = new MimeMessage(session);
		Transport transport = null;
		try {
			// 加载发件人地址
			message.setFrom(new InternetAddress(SystemConfig.getMailUser()));
			// 加载收件人地址
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			// 加载标题
			message.setSubject(subject);
			
			message.setSentDate(new Date());
			
			message.setContent(content, "text/html;charset=utf-8");
			
			// 发送邮件
			transport = session.getTransport("smtp");
			// 连接服务器的邮箱
			transport.connect(SystemConfig.getMailSmtp(), SystemConfig.getMailUser(), SystemConfig.getMailPwd());
			// 把邮件发送出去
			transport.sendMessage(message, message.getAllRecipients());
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			if(transport != null){
				try {
					transport.close();
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
}
