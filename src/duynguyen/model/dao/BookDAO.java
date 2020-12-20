package duynguyen.model.dao;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import duynguyen.model.bean.Book;

@Repository
public class BookDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	private static final String TOTAL_BOOK = "SELECT COUNT(*) FROM products INNER JOIN categories ON products.cid = categories.cid";
	private static final String FIND_ALL_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid ORDER BY bid DESC LIMIT ?, ?";
	private static final String FIND_ALL_BY_CID_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.cid = ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String TOTAL_BOOK_BY_CID = "SELECT COUNT(*) FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.cid = ?";
	private static final String ADD_ITEM = "INSERT INTO products(bname, decription, detail, picture, count_view, price, discount, create_by, cid, enable) VALUES (?,?,?,?,?,?,?,?,?,?)";
	private static final String UPDATE_ONE = "UPDATE products SET bname = ?, decription = ?, detail = ?, picture = ?, price = ?, create_by = ?, products.cid = ? WHERE bid = ?";
	private static final String FIND_ONE_BY_BID = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid WHERE bid = ?";
	private static final String DELETE_ONE = "DELETE FROM products WHERE bid = ?";
	private static final String TOTAL_BY_SEARCH = "SELECT COUNT(*) FROM products INNER JOIN categories ON products.cid = categories.cid WHERE bname LIKE ?";
	private static final String FIND_ALL_BY_SEARCH_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid WHERE bname LIKE ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String ACTIVE_BOOK = "UPDATE products SET enable = ? WHERE bid =?";
	private static final String TOTAL_BOOK_PUBLIC = "SELECT COUNT(*) FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.enable = 1";
	private static final String FIND_ALL_PUBLIC_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.enable = 1 ORDER BY bid DESC LIMIT ?, ?";
	private static final String FIND_ONE_BY_BID_PUBLIC = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid WHERE bid = ? AND products.enable = 1";
	private static final String TOTAL_BOOK_BY_PARENT_PUBLIC = "SELECT COUNT(*) FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.enable = 1 AND categories.parent_id = ?";
	private static final String TOTAL_BOOK_BY_CID_PUBLIC = "SELECT COUNT(*) FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.cid = ? AND products.enable = 1";
	private static final String FIND_ALL_BY_PARENT_ID_PUBLIC_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.enable = 1 AND categories.parent_id = ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String FIND_ALL_BY_CID_PUBLIC_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.enable = 1 AND products.cid = ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String FIND_ALL_BY_CID_PUBLIC_LQ = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.enable = 1 AND products.cid = ? AND products.bid != ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String TOTAL_BOOK_BY_SEARCH_PUBLIC = "SELECT COUNT(*) FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.enable = 1 AND products.bname LIKE ?";
	private static final String FIND_ALL_BY_SEARCH_PAGINATION_PUBLIC = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.bname LIKE ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String COUNT_VIEW = "UPDATE products SET count_view = count_view + 1 WHERE bid = ?";
	private static final String FIND_ALL_BY_COUNT_VIEW = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, products.create_by, date_create, products.enable, products.cid, categories.cname FROM products INNER JOIN categories ON products.cid = categories.cid ORDER BY count_view DESC LIMIT ?, ?";
	private static final String TOTAL_PRODUCT_BY_PARENT_ID_PUBLIC = "SELECT COUNT(*) FROM products INNER JOIN categories ON products.cid = categories.cid WHERE products.enable = 1 AND categories.parent_id = ?";

	public int totalProductByParentIdPublic(int cid) {
		return jdbcTemplate.queryForObject(TOTAL_PRODUCT_BY_PARENT_ID_PUBLIC, new Object[] { cid }, Integer.class);
	}

	public List<Book> getItemsCountView(int offset, int rowcount) {
		return jdbcTemplate.query(FIND_ALL_BY_COUNT_VIEW, new Object[] { offset, rowcount },
				new BeanPropertyRowMapper<Book>(Book.class));
	}

	public int countView(int bid) {
		return jdbcTemplate.update(COUNT_VIEW, new Object[] { bid });
	}

	public List<Book> getItemPublicByCidLQ(int bid, int cid, int offset, int rowCountPublic) {
		return jdbcTemplate.query(FIND_ALL_BY_CID_PUBLIC_LQ, new Object[] { cid, bid, offset, rowCountPublic },
				new BeanPropertyRowMapper<Book>(Book.class));
	}

	public List<Book> getItemPublicByCid(Integer cid, int offset, int rowCountPublic) {
		return jdbcTemplate.query(FIND_ALL_BY_CID_PUBLIC_PAGINATION, new Object[] { cid, offset, rowCountPublic },
				new BeanPropertyRowMapper<Book>(Book.class));
	}

	public List<Book> getItemsPublicByParentId(int cid, int offset, int rowCountPublic) {
		return jdbcTemplate.query(FIND_ALL_BY_PARENT_ID_PUBLIC_PAGINATION, new Object[] { cid, offset, rowCountPublic },
				new BeanPropertyRowMapper<Book>(Book.class));
	}

	public List<Book> getItemsPublicPagination(int offset, int rowCountPublic) {
		return jdbcTemplate.query(FIND_ALL_PUBLIC_PAGINATION, new Object[] { offset, rowCountPublic },
				new BeanPropertyRowMapper<Book>(Book.class));
	}

	public List<Book> getItemsLasted(int offset, int rowcount) {
		return jdbcTemplate.query(FIND_ALL_PAGINATION, new Object[] { offset, rowcount },
				new BeanPropertyRowMapper<Book>(Book.class));
	}

	public int updateActive(Integer id, int i) {
		return jdbcTemplate.update(ACTIVE_BOOK, new Object[] { i, id });
	}

	public List<Book> getItemsBySearch(String search, int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_BY_SEARCH_PAGINATION, new Object[] { "%" + search + "%", offset, rowCount },
				new BeanPropertyRowMapper<Book>(Book.class));
	}

	public int totalItemsBySearch(String search) {
		return jdbcTemplate.queryForObject(TOTAL_BY_SEARCH, new Object[] { "%" + search + "%" }, Integer.class);
	}

	public int deleteItem(Integer bid) {
		return jdbcTemplate.update(DELETE_ONE, new Object[] { bid });
	}

	public int editItem(@Valid Book objPro) {
		return jdbcTemplate.update(UPDATE_ONE,
				new Object[] { objPro.getBname(), objPro.getDecription(), objPro.getDetail(), objPro.getPicture(),
						objPro.getPrice(), objPro.getCreate_by(), objPro.getCid(), objPro.getBid() });
	}

	public Book getItemByBid(int bid) {
		try {
			return jdbcTemplate.queryForObject(FIND_ONE_BY_BID, new Object[] { bid },
					new BeanPropertyRowMapper<Book>(Book.class));
		} catch (Exception e) {
			return null;
		}
	}

	public int addItem(@Valid Book objPro) {
		return jdbcTemplate.update(ADD_ITEM,
				new Object[] { objPro.getBname(), objPro.getDecription(), objPro.getDetail(), objPro.getPicture(),
						objPro.getCount_view(), objPro.getPrice(), objPro.getDiscount(), objPro.getCreate_by(),
						objPro.getCid(), objPro.getEnable() });
	}

	public int totalProductPublicByParent(int cid) {
		return jdbcTemplate.queryForObject(TOTAL_BOOK_BY_PARENT_PUBLIC, new Object[] { cid }, Integer.class);
	}

	public int totalProductPublic() {
		return jdbcTemplate.queryForObject(TOTAL_BOOK_PUBLIC, Integer.class);
	}

	public int totalProduct() {
		return jdbcTemplate.queryForObject(TOTAL_BOOK, Integer.class);
	}

	public List<Book> getItems(int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_PAGINATION, new Object[] { offset, rowCount },
				new BeanPropertyRowMapper<Book>(Book.class));
	}

	public int totalProductBySearchPublic(String search) {
		return jdbcTemplate.queryForObject(TOTAL_BOOK_BY_SEARCH_PUBLIC, new Object[] { "%" + search + "%" },
				Integer.class);
	}

	public int totalBookByCidPublic(Integer cid) {
		return jdbcTemplate.queryForObject(TOTAL_BOOK_BY_CID_PUBLIC, new Object[] { cid }, Integer.class);
	}

	public int totalBookByCid(Integer cid) {
		return jdbcTemplate.queryForObject(TOTAL_BOOK_BY_CID, new Object[] { cid }, Integer.class);
	}

	public List<Book> getItemsByCid(Integer cid, int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_BY_CID_PAGINATION, new Object[] { cid, offset, rowCount },
				new BeanPropertyRowMapper<Book>(Book.class));
	}

	public Book getItemByBidPublic(Integer bid) {
		try {
			return jdbcTemplate.queryForObject(FIND_ONE_BY_BID_PUBLIC, new Object[] { bid },
					new BeanPropertyRowMapper<Book>(Book.class));
		} catch (Exception e) {
			return null;
		}
	}

	public List<Book> getItemsBySearchPaginationPublic(String search, int offset, int rowCountPublic) {
		return jdbcTemplate.query(FIND_ALL_BY_SEARCH_PAGINATION_PUBLIC,
				new Object[] { "%" + search + "%", offset, rowCountPublic },
				new BeanPropertyRowMapper<Book>(Book.class));
	}

}
