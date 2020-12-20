package vn.edu.vinaenter.controller;

import java.security.Principal;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import vn.edu.vinaenter.model.bean.Role;
import vn.edu.vinaenter.model.bean.User;
import vn.edu.vinaenter.model.dao.RoleDao;
import vn.edu.vinaenter.model.dao.UserDao;

@Controller
@RequestMapping("admin/user")
public class AdminUserController {
	@Autowired
	private UserDao userDao;

	@Autowired
	private RoleDao roleDao;

	@Autowired
	BCryptPasswordEncoder encoder;

	@ModelAttribute
	public void common(ModelMap modelMap, Principal principal) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		modelMap.addAttribute("inforUser", inforUser);
	}

	@GetMapping({ "index/{i}", "index" })
	public String index(ModelMap modelMap, @PathVariable(name = "i", required = false) Integer currentPage,
			RedirectAttributes ra) {
		if (currentPage == null || currentPage < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/user/index/1";
		}
		int totalUser = userDao.totalUser();
		int numberOfPage = (int) Math.ceil((double) totalUser / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/user/index/" + numberOfPage;
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT;
		List<User> listUser = userDao.getItems(offset, Defines.ROW_COUNT);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("listUser", listUser);
		return "bookstore.admin.user.index";
	}

	@GetMapping({ "profile/{id}" })
	public String profile(Principal principal, ModelMap modelMap,
			@PathVariable(name = "id", required = false) Integer id, RedirectAttributes ra) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		if (id == null) {
			User objUser = userDao.getItemByUsername1(principal.getName());
			modelMap.addAttribute("objUser", objUser);
			return "bookstore.admin.user.profile";
		}
		if ("ADMIN".equals(inforUser.getName())) {
			User objUser = userDao.getItemById(id);
			if (objUser == null) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
				return "redirect:/admin/user/index/1";
			} else {
				modelMap.addAttribute("objUser", objUser);
				return "bookstore.admin.user.profile";
			}
		} else {
			if (inforUser.getId() == id) {
				User objUser = userDao.getItemById(id);
				if (objUser == null) {
					ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
					return "redirect:/admin/user/index/1";
				} else {
					modelMap.addAttribute("objUser", objUser);
					return "bookstore.admin.user.profile";
				}
			} else {
				return "error/404";
			}
		}

	}

	@GetMapping({ "edit/{id}/{page}" })
	public String edit(ModelMap modelMap, @PathVariable(name = "id", required = false) Integer id,
			@PathVariable(name = "page", required = false) Integer currentPage, RedirectAttributes ra,
			Principal principal) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		if (currentPage == null || currentPage < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/user/index/1";
		}
		int totalUser = userDao.totalUser();
		int numberOfPage = (int) Math.ceil((double) totalUser / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/user/index/" + numberOfPage;
		}
		if ("ADMIN".equals(inforUser.getName())) {
			User objUser = userDao.getItemById(id);
			if (objUser != null) {
				List<Role> listRole = roleDao.getItems();
				modelMap.addAttribute("listRole", listRole);
				modelMap.addAttribute("objUser", objUser);
				return "bookstore.admin.user.edit";
			} else {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
				return "redirect:/admin/user/index/" + currentPage;
			}
		} else {
			if (inforUser.getId() == id) {
				User objUser = userDao.getItemById(id);
				if (objUser != null) {
					List<Role> listRole = roleDao.getItems();
					modelMap.addAttribute("listRole", listRole);
					modelMap.addAttribute("objUser", objUser);
					return "bookstore.admin.user.edit";
				} else {
					ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
					return "redirect:/admin/user/index/" + currentPage;
				}
			} else {
				return "error/404";
			}
		}

	}

	@PostMapping("edit/{id}/{page}")
	public String edit(@PathVariable(name = "id", required = false) Integer id,
			@PathVariable(name = "page", required = false) Integer currentPage, RedirectAttributes ra,
			@Valid @ModelAttribute("objUser") User objUser, BindingResult br, Principal principal) {
		User objOldUser = userDao.getItemById(id);
		if (objOldUser == null) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/user/index/1";
		}
		if (br.hasErrors()) {
			return "bookstore.admin.user.edit";
		}
		if (currentPage == null || currentPage < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/user/index/1";
		}
		int totalUser = userDao.totalUser();
		int numberOfPage = (int) Math.ceil((double) totalUser / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/user/index/" + numberOfPage;
		}
		if (userDao.getItemByUsername(principal.getName()).getId() != 5 || id == 5) {
			objUser.setRole_id(objOldUser.getRole_id());
			objUser.setEnable(objOldUser.getEnable());
		}
		try {
			objUser.setPassword(objOldUser.getPassword());
			objUser.setId(id);
			try {
				if (objUser.getEnable() != 0) {
					objUser.setEnable(1);
				}
			} catch (NumberFormatException e) {
				objUser.setEnable(1);
			}
			if (userDao.editItem(objUser) > 0) {
				ra.addFlashAttribute("msg", Defines.MSG_UPDATE_SUCCESS);
				return "redirect:/admin/user/index/" + currentPage;
			} else {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "bookstore.admin.user.edit";
			}
		} catch (Exception e) {
			return "bookstore.admin.user.edit";
		}
	}

	@GetMapping("add")
	public String add(ModelMap modelMap) {
		modelMap.addAttribute("listRole", roleDao.getItems());
		return "bookstore.admin.user.add";
	}

	@PostMapping("add")
	public String add(@Valid @ModelAttribute("objUser") User objUser, BindingResult br, RedirectAttributes ra,
			ModelMap modelMap) {
		if (br.hasErrors()) {
			return "bookstore.admin.user.add";
		}
		if (userDao.getItemByUsername(objUser.getUsername()) == null) {
			String password = objUser.getPassword();
			objUser.setPassword(encoder.encode(password));
			objUser.setEnable(1);
			try {
				if (userDao.addItem(objUser) > 0) {
					ra.addFlashAttribute("msg", Defines.MSG_ADD_SUCCESS);
					return "redirect:/admin/user/index/1";
				} else {
					ra.addFlashAttribute("msg", Defines.MSG_ERROR);
					return "bookstore.admin.user.add";
				}
			} catch (Exception e) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "bookstore.admin.user.add";
			}
		} else {
			ra.addFlashAttribute("msg", Defines.MSG_USERNAME);
			return "redirect:/admin/user/add";
		}
	}

	@GetMapping("delete/{id}/{page}")
	public String delete(@PathVariable(name = "page", required = false) Integer currentPage,
			@PathVariable(name = "id", required = false) Integer id, ModelMap modelMap, RedirectAttributes ra,
			Principal principal) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		if (currentPage == null || currentPage < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/user/index/1";
		}
		int totalUser = userDao.totalUser();
		int numberOfPage = (int) Math.ceil((double) totalUser / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/user/index/" + numberOfPage;
		}
		if ("ADMIN".equals(inforUser.getName())) {
			if (id != 1) {
				User objUser = userDao.getItemById(id);
				if (objUser != null) {
					if (userDao.delete(id) > 0) {
						ra.addFlashAttribute("msg", Defines.MSG_DELETE_SUCCESS);
						return "redirect:/admin/user/index/" + currentPage;
					} else {
						ra.addFlashAttribute("msg", Defines.MSG_ERROR);
						return "redirect:/admin/user/index/" + currentPage;
					}
				} else {
					ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
					return "redirect:/admin/user/index/" + currentPage;
				}
			} else {
				return "error/404";
			}
		} else {
			return "error/404";
		}

	}

	@GetMapping({ "search", "search/{page}" })
	public String search(@PathVariable(name = "page", required = false) Integer currentPage,
			@RequestParam("search") String search, ModelMap modelMap, RedirectAttributes ra) {
		int totalSearch = userDao.totalUserBySearch(search);
		if (currentPage == null || currentPage < 1) {
			currentPage = 1;
		}
		int numberOfPage = (int) Math.ceil((double) totalSearch / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/user/search/" + numberOfPage + "?search=" + search;
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT;
		List<User> listUser = userDao.getItemBySearch(search, offset, Defines.ROW_COUNT);
		modelMap.addAttribute("search", search);
		modelMap.addAttribute("listUser", listUser);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		return "bookstore.admin.user.search";
	}
}
