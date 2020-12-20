package vn.edu.vinaenter.controller;

import java.security.Principal;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.edu.vinaenter.constant.Defines;
import vn.edu.vinaenter.model.bean.Category;
import vn.edu.vinaenter.model.bean.User;
import vn.edu.vinaenter.model.dao.CategoryDAO;
import vn.edu.vinaenter.model.dao.UserDao;

@Controller
@RequestMapping("admin/cat")
public class AdminCatController {
	@Autowired
	private CategoryDAO catDao;

	@Autowired
	private UserDao userDao;

	@ModelAttribute
	public void commonObject(ModelMap modelMap, Principal principal) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		List<Category> listCatParent = catDao.getItemsParent(0);
		modelMap.addAttribute("listCatParent", listCatParent);
		modelMap.addAttribute("inforUser", inforUser);
	}

	@GetMapping({ "index", "index/{page}", "index/{cid}/{page}" })
	public String index(@PathVariable(name = "page", required = false) Integer currentPage,
			@PathVariable(name = "cid", required = false) Integer cid, ModelMap modelMap, RedirectAttributes ra) {
		if (cid == null) {
			cid = 0;
		}
		if (currentPage == null || currentPage < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/cat/index/1";
		}
		int totalCat = catDao.totalCatParent(cid);
		if (totalCat == 0) {
			return "redirect:/admin/";
		}
		int numberOfPage = (int) Math.ceil((double) totalCat / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/cat/index/" + numberOfPage;
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT;
		List<Category> listCat = catDao.getItemsParent(cid, offset, Defines.ROW_COUNT);
		Category objCat = catDao.getItemByCid(cid);
		modelMap.addAttribute("objCat", objCat);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		modelMap.addAttribute("listCat", listCat);
		modelMap.addAttribute("catDao", catDao);
		return "bookstore.admin.cat.index";
	}

	@GetMapping("add")
	public String add(ModelMap modelMap) {
		return "bookstore.admin.cat.add";
	}

	@PostMapping("add")
	public String add(@Valid @ModelAttribute("objCat") Category objCat, BindingResult br, RedirectAttributes ra,
			Principal principal) {
		if (br.hasErrors()) {
			return "bookstore.admin.cat.add";
		}
		objCat.setCreate_by(principal.getName());
		try {
			if (catDao.addItem(objCat) > 0) {
				ra.addFlashAttribute("msg", Defines.MSG_ADD_SUCCESS);
				return "redirect:/admin/cat/index/" + objCat.getParent_id() + "/1";
			} else {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "redirect:/admin/cat/add";
			}
		} catch (Exception e) {
			return "bookstore.admin.cat.add";
		}
	}

	@GetMapping("delete/{cid}/{page}")
	public String delete(@PathVariable("cid") int cid,
			@PathVariable(name = "page", required = false) Integer currentPage, RedirectAttributes ra) {
		if (currentPage == null || currentPage < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/cat/index/1";
		}
		int totalCat = catDao.totalCat();
		int numberOfPage = (int) Math.ceil((double) totalCat / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/cat/index/" + numberOfPage;
		}
		Category objCat = catDao.getItemByCid(cid);
		if (objCat == null) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/user/index/" + currentPage;
		}
		List<Category> list = catDao.getItemsParent(cid);
		if (catDao.deleteItem(cid) > 0) {
			if (list.size() > 0) {
				if (catDao.deleteItemsParent(cid) > 0) {
					ra.addFlashAttribute("msg", Defines.MSG_DELETE_SUCCESS);
					return "redirect:/admin/cat/index/" + currentPage;
				} else {
					ra.addFlashAttribute("msg", Defines.MSG_ERROR);
					return "redirect:/admin/cat/index/" + currentPage;
				}
			} else {
				if (objCat.getParent_id() != 0) {
					ra.addFlashAttribute("msg", Defines.MSG_DELETE_SUCCESS);
					return "redirect:/admin/cat/index/" + objCat.getParent_id() + "/" + currentPage;
				}
				ra.addFlashAttribute("msg", Defines.MSG_DELETE_SUCCESS);
				return "redirect:/admin/cat/index/" + currentPage;
			}
		} else {
			if (objCat.getParent_id() != 0) {
				ra.addFlashAttribute("msg", Defines.MSG_DELETE_SUCCESS);
				return "redirect:/admin/cat/index/" + catDao.getItemByCid(objCat.getParent_id()) + "/" + currentPage;
			}
			ra.addFlashAttribute("msg", Defines.MSG_DELETE_SUCCESS);
			return "redirect:/admin/cat/index/" + currentPage;
		}
	}

	@GetMapping("edit/{cid}/{page}")
	public String edit(@PathVariable(name = "cid", required = false) Integer cid,
			@PathVariable(name = "page", required = false) Integer currentPage, ModelMap modelMap,
			RedirectAttributes ra) {
		Category objCat = catDao.getItemByCid(cid);
		if (objCat == null) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/cat/index/1";
		}
		if (currentPage == null || currentPage < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/cat/index/1";
		}
		int totalCat = catDao.totalCat();
		int numberOfPage = (int) Math.ceil((double) totalCat / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/cat/index/" + numberOfPage;
		}
		modelMap.addAttribute("objCat", objCat);
		return "bookstore.admin.cat.edit";
	}

	@PostMapping("edit/{cid}/{page}")
	public String edit(@Valid @ModelAttribute("objCat") Category objCat,
			@PathVariable(name = "page", required = false) Integer currentPage, BindingResult br,
			@PathVariable(name = "cid", required = false) Integer cid, RedirectAttributes ra, Principal principal) {
		if (br.hasErrors()) {
			return "bookstore.admin.cat.edit";
		}
		try {
			Category objCatOld = catDao.getItemByCid(cid);
			if (objCatOld.getParent_id() == 0) {
				objCat.setParent_id(0);
			}
			objCat.setCid(cid);
			objCat.setCreate_by(principal.getName());
			if (catDao.editItem(objCat) > 0) {
				ra.addFlashAttribute("msg", Defines.MSG_UPDATE_SUCCESS);
				if (objCat.getParent_id() != 0) {
					return "redirect:/admin/cat/index/" + objCat.getParent_id() + "/" + currentPage;
				}
				return "redirect:/admin/cat/index/" + currentPage;
			} else {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "bookstore.admin.cat.edit";
			}
		} catch (Exception e) {
			return "bookstore.admin.cat.edit";
		}
	}

	@GetMapping({ "search/{page}", "search" })
	public String search(@RequestParam("search") String search,
			@PathVariable(name = "page", required = false) Integer currentPage, ModelMap modelMap,
			RedirectAttributes ra) {
		if (currentPage == null) {
			currentPage = 1;
		}
		int totalCat = catDao.totalCatBySearch(search);
		int numberOfPage = (int) Math.ceil((double) totalCat / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/cat/index/" + numberOfPage;
		}
		if (currentPage < 1 || currentPage == null) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/cat/index/1";
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT;
		List<Category> listCat = catDao.getItemsBySearch(search, offset, Defines.ROW_COUNT);
		modelMap.addAttribute("listCat", listCat);
		modelMap.addAttribute("search", search);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		modelMap.addAttribute("catDao", catDao);
		return "bookstore.admin.cat.search";
	}

}
