package vn.edu.vinaenter.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.edu.vinaenter.model.bean.User;
import vn.edu.vinaenter.model.dao.BillDao;
import vn.edu.vinaenter.model.dao.UserDao;

@Controller
@RequestMapping("admin/total")
public class AdminTotalIncomeController {
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private BillDao billDao;

	@ModelAttribute
	public void commonObject(ModelMap modelMap, Principal principal) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		modelMap.addAttribute("inforUser", inforUser);
	}

	@GetMapping("index")
	public String index(ModelMap modelMap) {
		float totalIncome = billDao.totalIncome();
		modelMap.addAttribute("totalIncome", totalIncome);
		return "bookstore.admin.total.index";
	}

}
