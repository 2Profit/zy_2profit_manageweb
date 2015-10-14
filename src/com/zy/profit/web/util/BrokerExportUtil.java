package com.zy.profit.web.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.apache.commons.lang3.StringUtils;

import com.zy.broker.entity.BrokerExtInfo;

public class BrokerExportUtil {

	public static String[] excelTitle = new String[] { 
		"序号","中文名称","英文名称","官网链接","链接是否显示",
		"金银业贸易场（编号）","证监会（编号）","英国FCA（编号）","日本FSA（编号）",
		"公司属地","交易平台","业务形式" ,"喊单服务","账户分成","公司类型","产品","结算币值","产品点差","产品点差（最低）",
		"单次最低交易手数","单次最高交易手数","持仓手数上限","客户回佣交易编码","建仓手续费","平仓手续费","多仓利息","空仓利息","最低入金","开仓保证金", 
		"杠杆比例","强平百分比","EA支持","银联入金","人民币入金","出入金免手续费","公司推荐值","优惠活动","最后更新时间"};
	
	/**
	 * 转换成相应中文
	 * @param input
	 * @param chinese
	 * @return
	 */
	public static String toChinese(String input,String chinese){
		if(StringUtils.isNotBlank(input)){
			return "1".equals(input) ? chinese : "不"+chinese;
		}
		return StringUtils.EMPTY;
	}
	
	public static String companyArea(String input){
		if(StringUtils.isNotBlank(input)){
			if("0".equals(input))
				return "香港";
			if("1".equals(input))
				return "中国";
			if("2".equals(input))
				return "台湾";
			if("3".equals(input))
				return "澳门";
		}
		return StringUtils.EMPTY;
	}
	
	public static String platForm(String input){
		String returnStr = StringUtils.EMPTY;
		if(StringUtils.isNoneBlank(input)){
			if(input.contains("0"))
				returnStr += "MT4,";
			if(input.contains("1"))
				returnStr += "MT5,";
			if(input.contains("2"))
				returnStr += "GTS1,";
			if(input.contains("3"))
				returnStr += "GTS2,";
			if(input.contains("4"))
				returnStr += "mFinance,";
		}
		return returnStr; 
	}
	
	public static String serviceShape(String input){
		String returnStr = StringUtils.EMPTY;
		if(StringUtils.isNoneBlank(input)){
			if(input.contains("0"))
				returnStr += "代理";
			if(input.contains("1"))
				returnStr += "直销";
			if(input.contains("2"))
				returnStr += "混合";
		}
		return returnStr; 
	}
	
	public static String companyType(String input){
		String returnStr = StringUtils.EMPTY;
		if(StringUtils.isNoneBlank(input)){
			if(input.contains("0"))
				returnStr += "黄金,";
			if(input.contains("1"))
				returnStr += "外汇,";
			if(input.contains("2"))
				returnStr += "二元期权,";
			if(input.contains("3"))
				returnStr += "国际现货金银,";
			if(input.contains("4"))
				returnStr += "混合,";
		}
		return returnStr; 
	}
	
	public static String productType(String input){
		String returnStr = StringUtils.EMPTY;
		if(StringUtils.isNoneBlank(input)){
			if(input.contains("0"))
				returnStr += "伦敦金,";
			if(input.contains("1"))
				returnStr += "伦敦银,";
			if(input.contains("2"))
				returnStr += "港金,";
			if(input.contains("3"))
				returnStr += "人民币公斤条,";
			if(input.contains("4"))
				returnStr += "外汇,";
			if(input.contains("5"))
				returnStr += "原油,";
		}
		return returnStr; 
	}
	
	public static String moneyType(String input){
		String returnStr = StringUtils.EMPTY;
		if(StringUtils.isNoneBlank(input)){
			if(input.contains("0"))
				returnStr += "美元";
			if(input.contains("1"))
				returnStr += "人民币";
			if(input.contains("2"))
				returnStr += "港元";
			if(input.contains("3"))
				returnStr += "混合";
		}
		return returnStr;
	}
	
	public static String joinPrice(Object broker,String fieldName){
		String returnStr = StringUtils.EMPTY;
		if(StringUtils.isNoneBlank(fieldName)){
			try {
				Method methodLlg = BrokerExtInfo.class.getDeclaredMethod("get" + fieldName + "Llg");
				Method methodLls = BrokerExtInfo.class.getDeclaredMethod("get" + fieldName + "Lls");
				Method methodHkg = BrokerExtInfo.class.getDeclaredMethod("get" + fieldName + "Hkg");
				Method methodLkg = BrokerExtInfo.class.getDeclaredMethod("get" + fieldName + "Lkg");
				Method methodWh = BrokerExtInfo.class.getDeclaredMethod("get" + fieldName + "Wh");
				Method methodYy = BrokerExtInfo.class.getDeclaredMethod("get" + fieldName + "Yy");
				try {
					returnStr += "伦敦金(" + nullToEmptyString(methodLlg.invoke(broker))+"),";
					returnStr += "伦敦银(" + nullToEmptyString(methodLls.invoke(broker))+"),";
					returnStr += "港金(" + nullToEmptyString(methodHkg.invoke(broker))+"),";
					returnStr += "人民币公斤条("+nullToEmptyString(methodLkg.invoke(broker))+"),";
					returnStr += "外汇(" + nullToEmptyString(methodWh.invoke(broker))+"),";
					returnStr += "原油(" + nullToEmptyString(methodYy.invoke(broker))+"),";
					
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			}
		}
		return returnStr;
	}
	
	public static String nullToEmptyString(Object object){
		String returnStr = StringUtils.EMPTY;
		if(object == null){
			return returnStr;
		}else{
			returnStr = object.toString();
		}
		return returnStr; 
	}
}
