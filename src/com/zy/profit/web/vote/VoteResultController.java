package com.zy.profit.web.vote;

import java.util.Arrays;
import java.util.HashSet;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.common.entity.PageModel;
import com.zy.common.entity.ResultDto;
import com.zy.common.util.UserDto;
import com.zy.common.util.UserSessionUtil;
import com.zy.vote.dto.VoteTopicDto;
import com.zy.vote.entity.VoteMemberLog;
import com.zy.vote.entity.VoteTopicOption;
import com.zy.vote.service.VoteMemberLogService;
import com.zy.vote.service.VoteTopicOptionService;
import com.zy.vote.service.VoteTopicPostReplayService;
import com.zy.vote.service.VoteTopicService;

/**
 * 投票结果Controller
 * 
 * <p>主要用于查询投票结果，以及修改投票结果数据</p>
 * 
 * @author Pingan
 *
 * @since  2015年9月13日
 */

@Controller
@RequestMapping("/voteResult")
public class VoteResultController {

	@Autowired
	private VoteTopicService voteTopicService;
	@Autowired
	private VoteTopicOptionService voteTopicOptionService;
	@Autowired
	private VoteTopicPostReplayService voteTopicPostReplayService;
	@Autowired
	private VoteMemberLogService voteMemberLogService;
	
	@RequestMapping("/list")
	public String list(Model model,VoteTopicDto queryDto){
		
		model.addAttribute("page", voteTopicService.queryPage(queryDto));
		model.addAttribute("queryDto", queryDto);
		
		return "vote/voteResultList";
	}
	
	@RequestMapping("/detail/list")
	public String list(Model model,VoteMemberLog queryDto,PageModel<VoteMemberLog> pageModel){
		
		model.addAttribute("page", voteMemberLogService.queryForPage(queryDto, pageModel));
		model.addAttribute("queryDto", queryDto);
		
		return "vote/voteResultDetailList";
	}
	
	@RequestMapping("/editOptionCount")
	@ResponseBody
	public ResultDto<VoteTopicOption> resultEdit(@RequestBody VoteTopicOption queryDto){
		ResultDto<VoteTopicOption> result = new ResultDto<VoteTopicOption>();
		try {
			for(String idNumer: new HashSet<String>(Arrays.asList(queryDto.getIdsAdjust()))){
				if(idNumer.split("~").length==2){
					VoteTopicOption optionEntity = voteTopicOptionService.get(idNumer.split("~")[0]);
					optionEntity.setVoteCount(optionEntity.getVoteCount() + new Integer(idNumer.split("~")[1]));
					voteTopicOptionService.update(optionEntity);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	
	@RequestMapping("/optionCount")
	@ResponseBody
	public ResultDto<VoteTopicOption> voteResult(VoteTopicDto queryDto){
		ResultDto<VoteTopicOption> result = new ResultDto<VoteTopicOption>();
		try {
			result.setList(voteTopicOptionService.getOptionByVoteTopic(queryDto.getId()));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
}
