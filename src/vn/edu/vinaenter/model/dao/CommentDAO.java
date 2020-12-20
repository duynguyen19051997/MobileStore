package vn.edu.vinaenter.model.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import vn.edu.vinaenter.model.bean.Comment;

@Repository
public class CommentDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private static final String ADD_ONE = "INSERT INTO comments(content, uid, parent_id, bid, active) VALUE(?,?,?,?,?)";
	private static final String FIND_ALL_BY_BID_PUBLIC = "SELECT c.*, u.id, u.username FROM comments AS c INNER JOIN users AS u ON c.uid = u.id WHERE bid = ? AND c.active = 1 ORDER BY c.date_create DESC";
	private static final String TOTAL_ALL_BY_BID_PUBLIC = "SELECT COUNT(*) FROM comments AS c INNER JOIN users AS u ON c.uid = u.id WHERE bid = ?";
	private static final String TOTAL_ALL = "SELECT COUNT(*) FROM comments AS c INNER JOIN users AS u ON c.uid = u.id ORDER BY uid DESC";
	private static final String FIND_ALL_PAGINATION = "SELECT c.*, u.id, u.username, b.bname FROM comments AS c INNER JOIN users AS u ON c.uid = u.id INNER JOIN products AS b ON c.bid = b.bid ORDER BY c.cmt_id DESC LIMIT ?, ?";
	private static final String ACTIVE_COMMENT = "UPDATE comments SET active = ? WHERE cmt_id = ?";
	private static final String DELETE_ONE_BY_CMT_ID = "DELETE comments WHERE cmt_id = ?";
	private static final String FIND_ONE_BY_CMT_ID = "SELECT c.*, u.id, u.username FROM comments AS c INNER JOIN users AS u ON c.uid = u.id WHERE cmt_id = ?";
	private static final String FIND_ALL_BY_SEARCH_PAGINATION = "SELECT c.*, u.id, u.username, b.bname FROM comments AS c INNER JOIN users AS u ON c.uid = u.id INNER JOIN products AS b ON c.bid = b.bid WHERE u.username LIKE ? ORDER BY c.cmt_id DESC LIMIT ?, ?";
	private static final String TOTAL_ALL_BY_SEARCH = "SELECT COUNT(*) FROM comments AS c INNER JOIN users AS u ON c.uid = u.id INNER JOIN products AS b ON c.bid = b.bid WHERE u.username LIKE ?";

	public int totalCmtBySearch(String search) {
		return jdbcTemplate.queryForObject(TOTAL_ALL_BY_SEARCH, new Object[] { "%" + search + "%" }, Integer.class);
	}

	public int deleteItemByCmt_id(Integer cmt_id) {
		return jdbcTemplate.update(DELETE_ONE_BY_CMT_ID, new Object[] { cmt_id });
	}

	public Comment getItemsByCmt_id(Integer cmt_id) {
		try {
			return jdbcTemplate.queryForObject(FIND_ONE_BY_CMT_ID, new Object[] { cmt_id },
					new BeanPropertyRowMapper<Comment>(Comment.class));
		} catch (Exception e) {
			return null;
		}
	}

	public int updateActive(Integer id, int i) {
		return jdbcTemplate.update(ACTIVE_COMMENT, new Object[] { i, id });
	}

	public List<Comment> getItems(int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_PAGINATION, new Object[] { offset, rowCount },
				new BeanPropertyRowMapper<Comment>(Comment.class));
	}

	public int totalCmt() {
		return jdbcTemplate.queryForObject(TOTAL_ALL, Integer.class);
	}

	public int addItems(Comment objComment) {
		return jdbcTemplate.update(ADD_ONE, new Object[] { objComment.getContent(), objComment.getId(),
				objComment.getParent_id(), objComment.getBid(), objComment.getActive() });
	}

	public List<Comment> getItemsByBidPublic(Integer bid) {
		return jdbcTemplate.query(FIND_ALL_BY_BID_PUBLIC, new Object[] { bid },
				new BeanPropertyRowMapper<Comment>(Comment.class));
	}

	public int totalCmtByBidPublic(Integer bid) {
		return jdbcTemplate.queryForObject(TOTAL_ALL_BY_BID_PUBLIC, new Object[] { bid }, Integer.class);
	}

	public List<Comment> getItemsBySearch(String search, int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_BY_SEARCH_PAGINATION, new Object[] { "%" + search + "%", offset, rowCount },
				new BeanPropertyRowMapper<Comment>(Comment.class));
	}
}