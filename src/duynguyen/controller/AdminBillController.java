package duynguyen.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import duynguyen.constant.Defines;
import duynguyen.model.bean.Bill;
import duynguyen.model.bean.BillDetail;
import duynguyen.model.bean.User;
import duynguyen.model.dao.BillDao;
import duynguyen.model.dao.BillDetailDao;
import duynguyen.model.dao.UserDao;

@Controller
@RequestMapping("admin/bill")
public class AdminBillController {

	@Autowired
	private BillDao billDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private BillDetailDao billDetailDao;

	@ModelAttribute
	public void commonObject(ModelMap modelMap, Principal principal) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		modelMap.addAttribute("inforUser", inforUser);
	}

	@GetMapping({ "index", "index/{page}" })
	public String index(ModelMap modelMap, @PathVariable(name = "page", required = false) Integer currentPage,
			RedirectAttributes ra) {
		try {
			if (currentPage == null || currentPage < 0) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
				return "redirect:/admin/bill/index/1";
			}
		} catch (NumberFormatException e) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/bill/index/1";
		}
		int totalBill = billDao.totalBill();
		int numberOfPage = (int) Math.ceil((double) totalBill / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/bill/index/" + numberOfPage;
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT;
		List<Bill> listBill = billDao.getItemsByPagination(offset, Defines.ROW_COUNT);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		modelMap.addAttribute("listBill", listBill);
		modelMap.addAttribute("currentPage", currentPage);
		return "bookstore.admin.bill.index";
	}

	@GetMapping({ "search", "search/{page}" })
	public String search(ModelMap modelMap, @RequestParam("search") String search,
			@PathVariable(name = "page", required = false) Integer currentPage, RedirectAttributes ra) {
		try {
			if (currentPage == null || currentPage < 1) {
				currentPage = 1;
			}
		} catch (NumberFormatException e) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/bill/index/1";
		}
		int totalBillBySearch = billDao.totalBillBySearch(search);
		int numberOfPage = (int) Math.ceil((double) totalBillBySearch / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/bill/index/" + numberOfPage;
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT;
		List<Bill> listBillBySearch = billDao.getItemsBySearchPagnation(search, offset, Defines.ROW_COUNT);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		modelMap.addAttribute("listBill", listBillBySearch);
		modelMap.addAttribute("search", search);
		return "bookstore.admin.bill.search";
	}

	@GetMapping({ "detail", "detail/{bill_id}/{page}" })
	public String detail(ModelMap modelMap, @PathVariable(name = "bill_id", required = false) Integer billId,
			@PathVariable(name = "page", required = false) Integer currentPage, RedirectAttributes ra) {
		int numberOfPage = billDao.totalBill();
		try {
			if (currentPage == null || currentPage < 1) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
				return "redirect:/admin/bill/index/1";
			}
		} catch (NumberFormatException e) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/bill/index/1";
		}
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/bill/index/" + numberOfPage;
		}
		try {
			if (billId == null) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
				return "redirect:/admin/bill/index/" + currentPage;
			}
		} catch (Exception e) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/bill/index/" + currentPage;
		}
		Bill objBill = (Bill) billDao.getItemByBillId(billId);
		if (objBill == null) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_BILL_ID);
			return "redirect:/admin/bill/index/" + currentPage;
		}
		List<BillDetail> listDetaiBill = billDetailDao.getItemsByBillId(billId);
		if (listDetaiBill.size() < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_BILL_ID);
			return "redirect:/admin/bill/index/" + currentPage;
		}
		modelMap.addAttribute("listDetaiBill", listDetaiBill);
		System.out.println(listDetaiBill.size());
		modelMap.addAttribute("objBill", objBill);
		return "bookstore.admin.bill.detail";
	}

	@GetMapping("delete")
	public String delete() {
		return "bookstore.admin.bill.index";
	}
}
