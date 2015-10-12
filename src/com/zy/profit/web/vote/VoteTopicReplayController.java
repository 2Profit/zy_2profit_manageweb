package com.zy.profit.web.vote;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zy.common.entity.PageModel;
import com.zy.vote.entity.VoteTopicPostReplay;
import com.zy.vote.service.VoteTopicPostReplayService;

@Controller
@RequestMapping("voteTopicReplay")
public class VoteTopicReplayController {

	@Autowired
	private VoteTopicPostReplayService voteTopicPostReplayService;
	
	@RequestMapping("/list")
	public String memberOption(Model model,VoteTopicPostReplay queryDto,
			PageModel<VoteTopicPostReplay> pageModel){
		
		model.addAttribute("page", voteTopicPostReplayService.queryForPage(queryDto, pageModel));
		model.addAttribute("queryDto", queryDto);
		
		return "/vote/voteTopicReplayList";
	}
	
}
