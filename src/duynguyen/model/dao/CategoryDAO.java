package duynguyen.model.dao;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import duynguyen.model.bean.Category;

@Repository
public class CategoryDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	/*
	 * =============================================================================
	 */
	private static final String FIND_ALL = "SELECT * FROM categories ORDER BY cid DESC";
	private static final String FIND_ALL_PAGINATION = "SELECT * FROM categories ORDER BY cid DESC LIMIT ?,?";
	private static final String TOTAL_CAT = "SELECT COUNT(*) FROM categories";
	private static final String TOTAL_CAT_PARENT = "SELECT COUNT(*) FROM categories WHERE parent_id = ?";
	private static final String FIND_CAT_BY_CID = "SELECT * FROM categories WHERE cid = ?";
	private static final String ADD_CAT = "INSERT INTO categories(cname, parent_id, create_by) VALUES(?, ?, ?)";
	private static final String DELETE_CAT = "DELETE FROM categories WHERE cid = ?";
	private static final String DELETE_CAT_PARENT = "DELETE FROM categories WHERE parent_id = ?";
	private static final String FIND_CAT_PARENT = "SELECT * FROM categories WHERE parent_id = ?";
	private static final String FIND_CAT_PARENT_PAGINATION = "SELECT * FROM categories WHERE parent_id = ? ORDER BY cid DESC LIMIT ?, ?";
	private static final String UPDATE_CAT = "UPDATE categories SET cname = ?, parent_id = ?, create_by = ? WHERE cid = ?";
	private static final String TOTAL_CAT_BY_SEARCH = "SELECT COUNT(*) FROM categories WHERE cname LIKE ?";
	private static final String SEARCH_PAGINATION = "SELECT * FROM categories WHERE cname LIKE ? LIMIT ?, ?";
	private static final String FIND_ALL_CHILD = "SELECT * FROM categories WHERE parent_id != 0 ORDER BY cid DESC";
	private static final String FIND_ALL_PARENT = "SELECT * FROM categories WHERE parent_id = 0 ORDER BY cid DESC";

	/*
	 * =============================================================================
	 */
	
	public List<Category> getItemsParent() {
		return jdbcTemplate.query(FIND_ALL_PARENT, new BeanPropertyRowMapper<Category>(Category.class));
	}

	public List<Category> getItemsChil() {
		return jdbcTemplate.query(FIND_ALL_CHILD, new BeanPropertyRowMapper<Category>(Category.class));
	}

	public List<Category> getItemsBySearch(String search, int offset, int rowCount) {
		return jdbcTemplate.query(SEARCH_PAGINATION, new Object[] { "%" + search + "%", offset, rowCount },
				new BeanPropertyRowMapper<Category>(Category.class));
	}

	public int totalCatBySearch(String search) {
		return jdbcTemplate.queryForObject(TOTAL_CAT_BY_SEARCH, new Object[] { "%" + search + "%" }, Integer.class);
	}

	public int editItem(@Valid Category objCat) {
		return jdbcTemplate.update(UPDATE_CAT,
				new Object[] { objCat.getCname(), objCat.getParent_id(), objCat.getCreate_by(), objCat.getCid() });
	}

	public List<Category> getItemsParent(int i, int offset, int rowCount) {
		return jdbcTemplate.query(FIND_CAT_PARENT_PAGINATION, new Object[] { i, offset, rowCount },
				new BeanPropertyRowMapper<Category>(Category.class));
	}

	public List<Category> getItemsParent(int parentId) {
		return jdbcTemplate.query(FIND_CAT_PARENT, new Object[] { parentId },
				new BeanPropertyRowMapper<Category>(Category.class));
	}

	public int deleteItemsParent(int cid) {
		return jdbcTemplate.update(DELETE_CAT_PARENT, new Object[] { cid });
	}

	public int deleteItem(int cid) {
		return jdbcTemplate.update(DELETE_CAT, new Object[] { cid });
	}

	public Category getItemByCid(int cid) {
		try {
			return jdbcTemplate.queryForObject(FIND_CAT_BY_CID, new Object[] { cid },
					new BeanPropertyRowMapper<Category>(Category.class));
		} catch (Exception e) {
			return null;
		}
	}

	public int addItem(@Valid Category objCat) {
		return jdbcTemplate.update(ADD_CAT,
				new Object[] { objCat.getCname(), objCat.getParent_id(), objCat.getCreate_by() });
	}

	public List<Category> getItems() {
		return jdbcTemplate.query(FIND_ALL, new BeanPropertyRowMapper<Category>(Category.class));
	}

	public List<Category> getItems(int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_PAGINATION, new Object[] { offset, rowCount },
				new BeanPropertyRowMapper<Category>(Category.class));
	}

	public int totalCatParent(int i) {
		return jdbcTemplate.queryForObject(TOTAL_CAT_PARENT, new Object[] { i }, Integer.class);
	}

	public int totalCat() {
		return jdbcTemplate.queryForObject(TOTAL_CAT, Integer.class);
	}

}
