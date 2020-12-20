package vn.edu.vinaenter.model.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import vn.edu.vinaenter.model.bean.Slide;

@Repository
public class SlideDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private static final String ADD_ITEM = "INSERT INTO slides(slide, sort) VALUES (?, ?)";
	private static final String FIND_ALL = "SELECT * FROM slides ORDER BY sort DESC";
	private static final String FIND_ONE = "SELECT * FROM slides WHERE id = ?";
	private static final String EDIT_ONE = "UPDATE slides SET slide = ?, sort = ? WHERE id = ?";
	private static final String DELETE_ONE = "DELETE FROM slides WHERE id = ?";
	private static final String TOTAL_ALL = "SELECT COUNT(*) FROM slides";
	private static final String FIND_ALL_PAGINATION = "SELECT * FROM slides ORDER BY sort DESC LIMIT ?, ?";

	public int addItem(Slide objSlide) {
		return jdbcTemplate.update(ADD_ITEM, new Object[] { objSlide.getSlide(), objSlide.getSort() });
	}

	public List<Slide> getItem(int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_PAGINATION, new Object[] { offset, rowCount },
				new BeanPropertyRowMapper<Slide>(Slide.class));
	}

	public List<Slide> getItem() {
		return jdbcTemplate.query(FIND_ALL, new BeanPropertyRowMapper<Slide>(Slide.class));
	}

	public Slide getItemById(int id) {
		try {
			return jdbcTemplate.queryForObject(FIND_ONE, new Object[] { id },
					new BeanPropertyRowMapper<Slide>(Slide.class));
		} catch (Exception e) {
			return null;
		}
	}

	public int editItem(Slide objSlide) {
		return jdbcTemplate.update(EDIT_ONE,
				new Object[] { objSlide.getSlide(), objSlide.getSort(), objSlide.getId() });
	}

	public int deleteItem(Integer id) {
		return jdbcTemplate.update(DELETE_ONE, new Object[] { id });
	}

	public int totalSlide() {
		return jdbcTemplate.queryForObject(TOTAL_ALL, Integer.class);
	}

}
