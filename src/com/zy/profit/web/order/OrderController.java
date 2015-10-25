package com.zy.profit.web.order;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zy.common.entity.PageModel;
import com.zy.common.util.DateUtils;
import com.zy.personal.entity.MemOrder;
import com.zy.personal.service.MemOrderService;
import com.zy.profit.web.util.HttpUtils;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private MemOrderService memOrderService;
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model){
		Integer pageSize = HttpUtils.getPageSize(request);
		Integer currentPage = HttpUtils.getCurrentPage(request);
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		String orderId = request.getParameter("orderId");
		if(StringUtils.isNotBlank(orderId)){
			params.put("orderId", orderId.trim());
		}
		model.addAttribute("orderId", orderId);
		
		String memberNo = request.getParameter("memberNo");
		if(StringUtils.isNotBlank(memberNo)){
			params.put("memberNo", memberNo.trim());
		}
		model.addAttribute("memberNo", memberNo);
		
		String mobile = request.getParameter("mobile");
		if(StringUtils.isNotBlank(mobile)){
			params.put("mobile", mobile.trim());
		}
		model.addAttribute("mobile", mobile);
		
		String name = request.getParameter("name");
		if(StringUtils.isNotBlank(name)){
			params.put("name", "%" + name.trim() + "%");
		}
		model.addAttribute("name", name);
		
		Date startDate = DateUtils.getStartDate(request.getParameter("startDate"));
		if(startDate != null){
			params.put("startDate", startDate);
		}
		model.addAttribute("startDate", startDate);

		Date endDate = DateUtils.getStartDate(request.getParameter("endDate"));
		if(endDate != null){
			params.put("endDate", endDate);
		}
		model.addAttribute("endDate", endDate);
		
		PageModel<MemOrder> page = memOrderService.queryMemOrderPage(params, currentPage, pageSize);
		model.addAttribute("page", page);
		
		return "/order/list";
	}
}
