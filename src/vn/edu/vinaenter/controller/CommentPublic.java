package vn.edu.vinaenter.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import vn.edu.vinaenter.model.bean.Comment;
import vn.edu.vinaenter.model.bean.User;
import vn.edu.vinaenter.model.dao.CommentDAO;

@Controller
public class CommentPublic {

	@Autowired
	private CommentDAO cmtDao;

	@PostMapping("comment")
	public @ResponseBody List<Comment> commentAjax(HttpSession session, HttpServletRequest request,
			HttpServletResponse response, @RequestParam("aContent") String content,
			@RequestParam(name = "aBid", required = false) Integer bid) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			try {
				response.sendRedirect(request.getContextPath() + "/login.html");
			} catch (IOException e) {
			}
		}
		List<Comment> listCmt = new ArrayList<>();
		Comment objComment = new Comment(0, 0, user.getId(), bid, 1, user.getUsername(), content);
		if (cmtDao.addItems(objComment) > 0) {
			listCmt = cmtDao.getItemsByBidPublic(bid);
		}
		return listCmt;
	}
}
