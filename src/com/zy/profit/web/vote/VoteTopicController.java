package com.zy.profit.web.vote;

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

import com.zy.common.entity.ResultDto;
import com.zy.common.util.UserDto;
import com.zy.common.util.UserSessionUtil;
import com.zy.util.ImageUploadUtil;
import com.zy.vote.dto.VoteTopicDto;
import com.zy.vote.entity.VoteTopic;
import com.zy.vote.service.VoteTopicOptionService;
import com.zy.vote.service.VoteTopicService;

/**
 * 投票主题controller
 * @author Pingan
 * @since  2015年9月12日
 */

@Controller
@RequestMapping("/voteTopic")
public class VoteTopicController {
	
	@Autowired
	private VoteTopicService voteTopicService;
	@Autowired
	private VoteTopicOptionService voteTopicOptionService;
	
	@RequestMapping("/list")
	public String list(Model model,VoteTopicDto queryDto){
		
		model.addAttribute("page", voteTopicService.queryPage(queryDto));
		model.addAttribute("queryDto", queryDto);
		
		return "vote/voteTopicList";
	}
	
	@RequestMapping("/edit")
	public String edit(Model model,VoteTopicDto queryDto){
		
		if(StringUtils.isNotBlank(queryDto.getId())){
			model.addAttribute("voteTopic", voteTopicService.get(queryDto.getId()));
		}
		return "vote/voteTopicEdit";
	}
	
	private String uploadFile(MultipartFile multipart,VoteTopic entity) throws IllegalStateException, IOException{
		String originalFileName = multipart.getOriginalFilename();
		File convFile = new File(originalFileName);
        multipart.transferTo(convFile);
		return ImageUploadUtil.uploadFileHandler(convFile,VoteTopic.class.getSimpleName(),originalFileName,
				entity.getImageWidth(),entity.getImageHeight());
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public ResultDto<VoteTopic> save(VoteTopic dto,HttpServletRequest request,
			@RequestParam("file") MultipartFile file){
		
		ResultDto<VoteTopic> result = new ResultDto<VoteTopic>();
		try {
			//上传图片到服务器
			if(file!=null && !file.isEmpty()){
				String returnCode = uploadFile(file, dto);
				if(!"400".equals(returnCode)){
					dto.setImageUrl(returnCode);
				}
			}
			
			UserDto userDto = UserSessionUtil.getSessionUser(request.getSession());
			if(userDto!=null)
				dto.setCreateName(userDto.getUsername());
			if(StringUtils.isNotBlank(dto.getId())){
				voteTopicService.updateTopicAndOptions(dto);
			}else{
				voteTopicService.saveTopicAndOptions(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMessage(e.getMessage());
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/deleteFlag")
	public ResultDto<VoteTopic> deleteFlag(@RequestBody VoteTopicDto queryDto){
		ResultDto<VoteTopic> result = new ResultDto<VoteTopic>();
		try {
			voteTopicService.updateDeleteFlag(queryDto.getIds(),queryDto.getDeleteFlag());
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/validate")
	public ResultDto<VoteTopic> validate(VoteTopic dto){
		ResultDto<VoteTopic> result = new ResultDto<VoteTopic>();
		try {
			if(dto.getStartDate()!=null){
				int countNumb = voteTopicService.findTopicByStartDate(dto.getStartDate());
				if(countNumb>0){
					result.setSuccess(false);
					return result;
				}
			}
			if(dto.getStartDate()!=null){
				int countNumb = voteTopicService.findTopicByEndDate(dto.getEndDate());
				if(countNumb>0){
					result.setSuccess(false);
					return result;
				}
			}
		} catch (Exception e) {
			result.setSuccess(false);
			result.setCode(ResultDto.SERVER_ERROR_CODE);
			e.printStackTrace();
		}
		return result;
	}
	
}
