package com.zy.profit.web.vote;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.common.entity.PageModel;
import com.zy.common.entity.ResultDto;
import com.zy.vote.dto.VoteTopicDto;
import com.zy.vote.entity.VoteTopicOption;
import com.zy.vote.entity.VoteTopicPostReplay;
import com.zy.vote.service.VoteMemberLogService;
import com.zy.vote.service.VoteTopicOptionService;
import com.zy.vote.service.VoteTopicPostReplayService;
import com.zy.vote.service.VoteTopicService;

/**
 * 投票结果Controller
 * 
 * @author Pingan
 *
 * @since  2015年9月13日
 */

@Controller
@RequestMapping("/voteResult")
public class VoteResultController {

	@Autowired
	private VoteMemberLogService voteMemberLogService;
	@Autowired
	private VoteTopicService voteTopicService;
	@Autowired
	private VoteTopicOptionService voteTopicOptionService;
	@Autowired
	private VoteTopicPostReplayService voteTopicPostReplayService;
	
	@RequestMapping("/list")
	public String list(Model model,VoteTopicDto queryDto){
		
		model.addAttribute("page", voteTopicService.queryPage(queryDto));
		model.addAttribute("queryDto", queryDto);
		
		return "vote/voteResultList";
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
	
	@RequestMapping("/postReplay/list")
	public String memberOption(Model model,VoteTopicPostReplay queryDto,
			PageModel<VoteTopicPostReplay> pageModel){
		
		model.addAttribute("page", voteTopicPostReplayService.queryForPage(queryDto, pageModel));
		model.addAttribute("queryDto", queryDto);
		
		return "/vote/modelDialogReplayList";
	}
	
}
