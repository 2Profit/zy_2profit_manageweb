package com.zy.profit.web.vote;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.base.entity.Notice;
import com.zy.common.entity.ResultDto;
import com.zy.common.util.UserDto;
import com.zy.common.util.UserSessionUtil;
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
	
	@RequestMapping("/save")
	@ResponseBody
	public ResultDto<VoteTopic> save(VoteTopic dto,HttpServletRequest request){
		
		ResultDto<VoteTopic> result = new ResultDto<VoteTopic>();
		try {
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
	public ResultDto<Notice> deleteFlag(@RequestBody VoteTopicDto queryDto){
		ResultDto<Notice> result = new ResultDto<Notice>();
		try {
			voteTopicService.updateDeleteFlag(queryDto.getIds(),queryDto.getDeleteFlag());
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
}
