package vn.edu.vinaenter.controller;

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

import vn.edu.vinaenter.constant.Defines;
import vn.edu.vinaenter.model.bean.Comment;
import vn.edu.vinaenter.model.bean.User;
import vn.edu.vinaenter.model.dao.CommentDAO;
import vn.edu.vinaenter.model.dao.UserDao;

@Controller
@RequestMapping("admin/comment")
public class AdminCommentController {

	@Autowired
	private UserDao userDao;

	@Autowired
	private CommentDAO cmtDao;

	@ModelAttribute
	public void commonObject(ModelMap modelMap, Principal principal) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		modelMap.addAttribute("inforUser", inforUser);
	}

	@GetMapping({ "index", "index/{page}" })
	public String index(@PathVariable(name = "page", required = false) Integer currentPage, ModelMap modelMap,
			RedirectAttributes ra) {
		if (currentPage == null || currentPage < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/comment/index/1";
		}
		int totalCat = cmtDao.totalCmt();
		int numberOfPage = (int) Math.ceil((double) totalCat / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/comment/index/" + numberOfPage;
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT;
		List<Comment> listCmt = cmtDao.getItems(offset, Defines.ROW_COUNT);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		modelMap.addAttribute("listCmt", listCmt);
		return "bookstore.admin.comment.index";
	}

	@GetMapping({ "search/{page}", "search" })
	public String search(@RequestParam("search") String search, RedirectAttributes ra,
			@PathVariable(name = "page", required = false) Integer currentPage, ModelMap modelMap) {
		if (currentPage == null || currentPage < 1) {
			currentPage = 1;
		}
		int totalCmtBySearch = cmtDao.totalCmtBySearch(search);
		int numberOfPage = (int) Math.ceil((double) totalCmtBySearch / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/comment/index/1";
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT;
		List<Comment> listCmtBySearch = cmtDao.getItemsBySearch(search, offset, Defines.ROW_COUNT);
		modelMap.addAttribute("listCmtBySearch", listCmtBySearch);
		modelMap.addAttribute("search", search);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		return "bookstore.admin.comment.search";
	}

	@GetMapping("delete/{cmt_id}/{page}")
	public String delete(@PathVariable(name = "cmt_cid", required = false) Integer cmt_id,
			@PathVariable(name = "page", required = false) Integer currentPage, RedirectAttributes ra) {
		if (currentPage == null || currentPage < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/comment/index/1";
		}
		int totalCmt = cmtDao.totalCmt();
		int numberOfPage = (int) Math.ceil((double) totalCmt / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/comment/index/" + numberOfPage;
		}
		Comment objComment = cmtDao.getItemsByCmt_id(cmt_id);
		if (objComment == null) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/comment/index/" + currentPage;
		} else {
			if (cmtDao.deleteItemByCmt_id(cmt_id) > 0) {
				ra.addFlashAttribute("msg", Defines.MSG_DELETE_SUCCESS);
				return "redirect:/admin/comment/index/" + currentPage;
			} else {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "redirect:/admin/comment/index/" + currentPage;
			}
		}
	}
}
