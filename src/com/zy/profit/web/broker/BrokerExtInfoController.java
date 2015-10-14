package com.zy.profit.web.broker;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zy.broker.dto.BrokerExtInfoDto;
import com.zy.broker.entity.BrokerExtInfo;
import com.zy.broker.service.BrokerExtInfoService;
import com.zy.broker.service.BrokerInfoService;
import com.zy.common.entity.PageModel;
import com.zy.common.entity.ResultDto;
import com.zy.common.util.UserDto;
import com.zy.common.util.UserSessionUtil;
import com.zy.common.util.Util4Jxl;
import com.zy.profit.web.util.BrokerExportUtil;
import com.zy.util.ImageUploadUtil;

/**
 * 经纪商后台管理controller
 * 
 * @author Pingan
 * @since  2015年9月1日
 */

@Controller
@RequestMapping("/brokerExtInfo")
public class BrokerExtInfoController {
	
	

	@Autowired
	private BrokerExtInfoService brokerExtInfoService;
	@Autowired
	private BrokerInfoService brokerInfoService;
	
	@RequestMapping("/list")
	public String queryPage(BrokerExtInfoDto queryDto,PageModel<BrokerExtInfo> pageModel,Model model){
		
		model.addAttribute("page", brokerExtInfoService.queryForPage(queryDto, pageModel));
		model.addAttribute("queryDto",queryDto);
		
		return "broker/brokerExtInfoList";
	}
	
	@ResponseBody
	@RequestMapping("/deleteFlag")
	public ResultDto<BrokerExtInfo> deleteFlag(@RequestBody BrokerExtInfoDto queryDto){
		ResultDto<BrokerExtInfo> result = new ResultDto<BrokerExtInfo>();
		try {
			brokerExtInfoService.updateDeleteFlag(queryDto.getIds(),queryDto.getDeleteFlag());
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	@RequestMapping("/edit")
	public String edit(Model model,BrokerExtInfo entity){
		
		if(StringUtils.isNotBlank(entity.getId())){
			model.addAttribute("brokerExtInfo", brokerExtInfoService.get(entity.getId()));
		}
		return "broker/brokerExtInfoEdit";
	}
	
	/**
	 * 验证填写的经纪商中文名称、英文名称、公司推荐值、交易编号是否已经存在
	 * @param dto
	 * @return
	 */
	@RequestMapping("/validate")
	@ResponseBody
	public ResultDto<BrokerExtInfo> validate(BrokerExtInfo dto){
		ResultDto<BrokerExtInfo> result = new ResultDto<BrokerExtInfo>();
		try {
			if(StringUtils.isNoneBlank(dto.getCnName())){
				int countNumb = brokerExtInfoService.findByCnName(dto.getCnName());
				if(countNumb>0){
					result.setSuccess(false);
					return result;
				}
			}
			if(StringUtils.isNoneBlank(dto.getEnName())){
				int countNumb = brokerExtInfoService.findByEnName(dto.getEnName());
				if(countNumb>0){
					result.setSuccess(false);
					return result;
				}
			}
			if(dto.getCompanyIndex() != null){
				int countNumb = brokerExtInfoService.findByCompanyIndex(dto.getCompanyIndex());
				if(countNumb>0){
					result.setSuccess(false);
					return result;
				}
			}
			if(StringUtils.isNoneBlank(dto.getExchangeNo1())){
				int countNumb = brokerExtInfoService.findByExchangeNo1(dto.getExchangeNo1());
				if(countNumb>0){
					result.setSuccess(false);
					return result;
				}
			}
			if(StringUtils.isNoneBlank(dto.getExchangeNo2())){
				int countNumb = brokerExtInfoService.findByExchangeNo2(dto.getExchangeNo2());
				if(countNumb>0){
					result.setSuccess(false);
					return result;
				}
			}
			if(StringUtils.isNoneBlank(dto.getExchangeNo3())){
				int countNumb = brokerExtInfoService.findByExchangeNo3(dto.getExchangeNo3());
				if(countNumb>0){
					result.setSuccess(false);
					return result;
				}
			}
			if(StringUtils.isNoneBlank(dto.getExchangeNo4())){
				int countNumb = brokerExtInfoService.findByExchangeNo4(dto.getExchangeNo4());
				if(countNumb>0){
					result.setSuccess(false);
					return result;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	private String uploadFile(MultipartFile multipart,BrokerExtInfo entity) throws IllegalStateException, IOException{
		String originalFileName = multipart.getOriginalFilename();
		File convFile = new File(originalFileName);
        multipart.transferTo(convFile);
		return ImageUploadUtil.uploadFileHandler(convFile,BrokerExtInfo.class.getSimpleName(),originalFileName,
				entity.getImageWidth(),entity.getImageHeight());
	}
	
	@RequestMapping(value="/save", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public ResultDto<BrokerExtInfo> save(BrokerExtInfo dto,HttpServletRequest request,
			@RequestParam("file") MultipartFile file){
		
		ResultDto<BrokerExtInfo> result = new ResultDto<BrokerExtInfo>();
		try {
			//上传图片到服务器
			if(file!=null && !file.isEmpty()){
				String returnCode = uploadFile(file, dto);
				if(!"400".equals(returnCode)){
					dto.setImageUrl(returnCode);
				}
			}
			
			UserDto userDto = UserSessionUtil.getSessionUser(request.getSession());
			if(StringUtils.isNoneBlank(dto.getId())){
				brokerExtInfoService.update(dto);
			}else{
				dto.setCreateId(userDto.getId());
				dto.setCreateName(userDto.getUsername());
				brokerExtInfoService.save(dto);
			}
			result.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	@RequestMapping(value="/brokerCopy")
	public String brokerCopy(Model model, BrokerExtInfo dto){
		
		if(StringUtils.isNotBlank(dto.getId())){
			BrokerExtInfo brokerCopy = brokerExtInfoService.get(dto.getId());
			brokerCopy.setId(StringUtils.EMPTY);
			brokerCopy.setCnName(StringUtils.EMPTY);
			brokerCopy.setEnName(StringUtils.EMPTY);
			brokerCopy.setExchangeNo1(StringUtils.EMPTY);
			brokerCopy.setExchangeNo2(StringUtils.EMPTY);
			brokerCopy.setExchangeNo3(StringUtils.EMPTY);
			brokerCopy.setExchangeNo4(StringUtils.EMPTY);
			brokerCopy.setCompanyIndex(null);
			model.addAttribute("brokerExtInfo", brokerCopy);
		}
		return "broker/brokerExtInfoEdit";
	}
	
	@RequestMapping(value="/export")
	public void exportExl(BrokerExtInfoDto queryDto,HttpServletResponse response){
		try {
			List<BrokerExtInfo> list = brokerExtInfoService.queryForPage(queryDto,new PageModel<BrokerExtInfo>(200)).getList();
			if(CollectionUtils.isNotEmpty(list)){

				response.setContentType("application/msexcel");
				OutputStream os = null;
				WritableWorkbook wwb = null;
				String xlsName = URLDecoder.decode("经纪商导出.xls", "UTF-8");// 文件名称
				try {
					os = response.getOutputStream();
					response.setHeader("Content-Disposition", "attachment; filename="+ new String(xlsName.getBytes("GBK"), "ISO-8859-1"));
					wwb = Workbook.createWorkbook(os);
					WritableSheet ws = wwb.createSheet("report1", 0);
					// 合并单元格
					ws.mergeCells(0, 0, 38, 0);
					// 填充表头
					Label sheetTitle = new Label(0, 0, "经纪商信息", Util4Jxl.centerFormat);
					ws.addCell(sheetTitle);
					Util4Jxl.addLine(ws,BrokerExportUtil.excelTitle, 0, 1,Util4Jxl.centerFormat);
					// 填充列表
					addBrokerToCell(list, ws);
					wwb.write();

				} catch (IOException e) {
					e.printStackTrace();
					throw e;
				} finally {
					if (wwb != null) {
						wwb.close();
					}
					if (os != null) {
						os.close();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void addBrokerToCell(List<BrokerExtInfo> list, WritableSheet ws)
			throws WriteException, RowsExceededException {
		
		int row = 2;
		for (BrokerExtInfo broker:list) {
			int column = 0;
			ws.addCell(Util4Jxl.getCell(column++, row, row - 1, Util4Jxl.leftFormat));//excel第一列序号
			
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getCnName(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getEnName(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getWebsiteUrl(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.toChinese(broker.getIsShowUrl(),"显示"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getExchangeNo1(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getExchangeNo2(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getExchangeNo3(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getExchangeNo4(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.companyArea(broker.getCompanyArea()), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.platForm(broker.getPlatform()), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.serviceShape(broker.getServiceShape()), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.toChinese(broker.getIsSingalService(),"提供"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.toChinese(broker.getIsAccountSeperate(),"提供"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.companyType(broker.getCompanyType()), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.productType(broker.getProductType()), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.moneyType(broker.getMoneyType()), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.joinPrice(broker,"PointDiffMin"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.joinPrice(broker,"MinTradeNum"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.joinPrice(broker,"MaxTradeNum"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getMaxHoldNum(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getCommissionCode(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.toChinese(broker.getIsOpenFee(),"收取"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.toChinese( broker.getIsCloseFee(),"收取"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getLongRate(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getShortRate(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getMinIncomeMoney(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.joinPrice(broker,"OpenMoney"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getLeverRate(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getCloseRate(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getCloseRateExt(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.toChinese(broker.getIsEaSupport(),"支持"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.toChinese(broker.getIsUnionpay(),"支持"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.toChinese(broker.getIsRmbSupport(),"支持"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.toChinese(broker.getIsInOutFree(),"支持"), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getCompanyIndex(), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, BrokerExportUtil.nullToEmptyString(broker.getNoticeContent1())+";"+
					BrokerExportUtil.nullToEmptyString(broker.getNoticeContent2())+";"+
					BrokerExportUtil.nullToEmptyString(broker.getNoticeContent3()), Util4Jxl.leftFormat));
			ws.addCell(Util4Jxl.getCell(column++, row, broker.getUpdateDate(), Util4Jxl.leftFormat));
			
			row++;
		}
	}
	
	
}
