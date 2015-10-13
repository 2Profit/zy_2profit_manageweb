package com.zy.profit.web.broker;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

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
			//brokerCopy.setExchangeNo(StringUtils.EMPTY);
			brokerCopy.setCompanyIndex(null);
			model.addAttribute("brokerExtInfo", brokerCopy);
		}
		return "broker/brokerExtInfoEdit";
	}
}
