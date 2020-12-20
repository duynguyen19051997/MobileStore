package duynguyen.model.dao;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import duynguyen.model.bean.Blog;
import duynguyen.model.bean.Book;

@Repository
public class BlogDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	private static final String TOTAL_BOOK = "SELECT COUNT(*) FROM books INNER JOIN categories ON books.cid = categories.cid";
	private static final String FIND_ALL_PAGINATION = "SELECT bc.blog_id, bc.blog_name, bc.image, bc.content, bc.create_by, bc.create_date, bc.status, bc.count_view, c.cid, c.cname FROM blog_categories AS bc INNER JOIN categories AS c ON bc.cid = c.cid ORDER BY bc.blog_id DESC LIMIT ?, ?";
	private static final String FIND_ALL_BY_CID_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, books.create_by, date_create, books.enable, books.cid, categories.cname FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.cid = ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String TOTAL_BOOK_BY_CID = "SELECT COUNT(*) FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.cid = ?";
	private static final String ADD_ITEM = "INSERT INTO books(bname, decription, detail, picture, count_view, price, discount, create_by, cid, enable) VALUES (?,?,?,?,?,?,?,?,?,?)";
	private static final String UPDATE_ONE = "UPDATE books SET bname = ?, decription = ?, detail = ?, picture = ?, price = ?, create_by = ?, books.cid = ? WHERE bid = ?";
	private static final String FIND_ONE_BY_BID = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, books.create_by, date_create, books.enable, books.cid, categories.cname FROM books INNER JOIN categories ON books.cid = categories.cid WHERE bid = ?";
	private static final String DELETE_ONE = "DELETE FROM books WHERE bid = ?";
	private static final String TOTAL_BY_SEARCH = "SELECT COUNT(*) FROM books INNER JOIN categories ON books.cid = categories.cid WHERE bname LIKE ?";
	private static final String FIND_ALL_BY_SEARCH_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, books.create_by, date_create, books.enable, books.cid, categories.cname FROM books INNER JOIN categories ON books.cid = categories.cid WHERE bname LIKE ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String ACTIVE_BOOK = "UPDATE books SET enable = ? WHERE bid =?";
	private static final String TOTAL_BOOK_PUBLIC = "SELECT COUNT(*) FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.enable = 1";
	private static final String FIND_ALL_PUBLIC_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, books.create_by, date_create, books.enable, books.cid, categories.cname FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.enable = 1 ORDER BY bid DESC LIMIT ?, ?";
	private static final String FIND_ONE_BY_BID_PUBLIC = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, books.create_by, date_create, books.enable, books.cid, categories.cname FROM books INNER JOIN categories ON books.cid = categories.cid WHERE bid = ? AND books.enable = 1";
	private static final String TOTAL_BOOK_BY_PARENT_PUBLIC = "SELECT COUNT(*) FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.enable = 1 AND categories.parent_id = ?";
	private static final String TOTAL_BOOK_BY_CID_PUBLIC = "SELECT COUNT(*) FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.cid = ? AND books.enable = 1";
	private static final String FIND_ALL_BY_PARENT_ID_PUBLIC_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, books.create_by, date_create, books.enable, books.cid, categories.cname FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.enable = 1 AND categories.parent_id = ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String FIND_ALL_BY_CID_PUBLIC_PAGINATION = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, books.create_by, date_create, books.enable, books.cid, categories.cname FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.enable = 1 AND books.cid = ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String FIND_ALL_BY_CID_PUBLIC_LQ = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, books.create_by, date_create, books.enable, books.cid, categories.cname FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.enable = 1 AND books.cid = ? AND books.bid != ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String TOTAL_BOOK_BY_SEARCH_PUBLIC = "SELECT COUNT(*) FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.enable = 1 AND books.bname LIKE ?";
	private static final String FIND_ALL_BY_SEARCH_PAGINATION_PUBLIC = "SELECT bid, bname, decription, detail, picture, count_view, price, discount, books.create_by, date_create, books.enable, books.cid, categories.cname FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.bname LIKE ? ORDER BY bid DESC LIMIT ?, ?";
	private static final String COUNT_VIEW = "UPDATE blog_categories SET count_view = count_view + 1 WHERE blog_id = ?";
	private static final String FIND_ALL_BY_COUNT_VIEW = "SELECT bc.blog_id, bc.blog_name, bc.image, bc.content, bc.create_by, bc.create_date, bc.status, bc.count_view, c.cid, c.cname FROM blog_categories AS bc INNER JOIN categories AS c ON bc.cid = c.cid ORDER BY count_view DESC LIMIT ?, ?";
	private static final String TOTAL_PRODUCT_BY_PARENT_ID_PUBLIC = "SELECT COUNT(*) FROM books INNER JOIN categories ON books.cid = categories.cid WHERE books.enable = 1 AND categories.parent_id = ?";

	private static final String TOTAL_BLOG_BY_CID = "SELECT COUNT(*) FROM blog_categories AS bc INNER JOIN categories AS c ON bc.cid = c.cid";

	public int totalProductByParentIdPublic(int cid) {
		return jdbcTemplate.queryForObject(TOTAL_PRODUCT_BY_PARENT_ID_PUBLIC, new Object[] { cid }, Integer.class);
	}

	public List<Blog> getItemsCountView(int offset, int rowcount) {
		return jdbcTemplate.query(FIND_ALL_BY_COUNT_VIEW, new Object[] { offset, rowcount },
				new BeanPropertyRowMapper<Blog>(Blog.class));
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

	public int addItem(@Valid Blog objBlog) {
		return jdbcTemplate.update(ADD_ITEM,
				new Object[] { objBlog.getBlog_name(), objBlog.getImage(), objBlog.getContent(), objBlog.getCreate_by(),
						objBlog.getCreate_date(), objBlog.getStatus(), objBlog.getCount_view(), objBlog.getCid() });
	}

	public List<Blog> getItems(int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_PAGINATION, new Object[] { offset, rowCount },
				new BeanPropertyRowMapper<Blog>(Blog.class));
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

	public int totalBlog() {
		return jdbcTemplate.queryForObject(TOTAL_BLOG_BY_CID, new Object[] {}, Integer.class);
	}
}
