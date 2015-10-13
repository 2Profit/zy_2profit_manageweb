package com.zy.profit.web.broker;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

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
import com.zy.common.util.ExportExcelUtil4Jxl;
import com.zy.common.util.UserDto;
import com.zy.common.util.UserSessionUtil;
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
	
	public static String[] excelTitle = new String[] { 
		"中文名称","英文名称","官网链接","链接是否显示",
		"会员/监管机构1（编号）","会员/监管机构2（编号）","会员/监管机构3（编号）","会员/监管机构4（编号）",
		"公司属地","交易平台","业务形式" ,"喊单服务","账户分成","公司类型","产品","结算币值","产品点差","产品点差（最低）",
		"单次最低交易手数","单次最高交易手数","持仓手数上限","客户回佣交易编码","建仓手续费","平仓手续费","多仓利息","空仓利息","最低入金","开仓保证金", 
		"杠杆比例","强平百分比","EA支持","银联入金","人民币入金","出入金免手续费","公司推荐值","优惠活动","最后更新时间"};

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
			/*if(StringUtils.isNoneBlank(dto.getExchangeNo())){
				int countNumb = brokerExtInfoService.findByExchangeNo(dto.getExchangeNo());
				if(countNumb>0){
					result.setSuccess(false);
					return result;
				}
			}*/
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
	public ResultDto<Object> exportExl(BrokerExtInfoDto queryDto,HttpServletResponse response){
		ResultDto<Object> result = new ResultDto<Object>();
		try {
			//List<BrokerExtInfo> list = brokerExtInfoService.queryForPage(queryDto,new PageModel<BrokerExtInfo>(100)).getList();
			List<Object[]> list = new ArrayList<Object[]>();
			if(CollectionUtils.isNotEmpty(list)){

				// 组装excel
				response.setContentType("application/msexcel");
				OutputStream os = null;
				WritableWorkbook wwb = null;
				// 文件名称
				String xlsName = URLDecoder.decode("经纪商导出Excel", "UTF-8");
				try {
					os = response.getOutputStream();
					response.setHeader("Content-Disposition", "attachment; filename="+ new String(xlsName.getBytes("GBK"), "ISO-8859-1"));
					wwb = Workbook.createWorkbook(os);
					WritableSheet ws = wwb.createSheet("report1", 0);
					// 合并单元格
					ws.mergeCells(0, 0, 2, 0);
					// 设置列宽
					//ExportExcelUtil4Jxl.setColumnWidth(ws, 15, new int[] { 2, 4, 7 });
					//ExportExcelUtil4Jxl.setColumnWidth(ws, 20, new int[] { 3, 5, 6, 8,13 });
					// 填充表头
					Label sheetTitle = new Label(0, 0, "经纪商信息", ExportExcelUtil4Jxl.centerFormat);
					ws.addCell(sheetTitle);
					ExportExcelUtil4Jxl.addLine(ws,new Object[] {excelTitle}, 0, 1,ExportExcelUtil4Jxl.centerFormat);
					// 填充列表
					int row = 2;
					for (Object[] objects:list) {
						int column = 0;
						ws.addCell(ExportExcelUtil4Jxl.getWritableCell(column++, row,row - 1, ExportExcelUtil4Jxl.leftFormat));
						for (Object object : objects) {
							ws.addCell(ExportExcelUtil4Jxl.getWritableCell(column++, row,object, ExportExcelUtil4Jxl.leftFormat));
						}
						row++;
					}
					wwb.write();

				} catch (Exception e) {
					e.printStackTrace();
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
			result.setSuccess(false);
		}
		return result;
	}
	
}
