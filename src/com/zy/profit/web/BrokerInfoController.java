package com.zy.profit.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zy.broker.entity.BrokerInfo;
import com.zy.broker.service.BrokerInfoService;
import com.zy.common.entity.PageModel;

@Controller
@RequestMapping("/boss/brokerInfo")
public class BrokerInfoController {

	@Autowired
	private BrokerInfoService brokerInfoService;
	
	@RequestMapping("/list")
	public String queryPage(BrokerInfo queryDto,PageModel<BrokerInfo> pageModel,Model model){
		
		//model.addAttribute("page", brokerInfoService.queryForPage(queryDto, pageModel));
		model.addAttribute("queryDto",queryDto);
		
		return "broker/brokerList";
	}
}
