package com.zy.profit.web.order;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zy.common.entity.PageModel;
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
		
		PageModel<MemOrder> page = memOrderService.queryMemOrderPage(null, currentPage, pageSize);
		model.addAttribute("page", page);
		
		return "/order/list";
	}
}
