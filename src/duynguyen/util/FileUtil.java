package duynguyen.util;

import org.apache.commons.io.FilenameUtils;

public class FileUtil {
	public static String rename(String filename) {
		if (!"".equals(filename)) {
			return FilenameUtils.getBaseName(filename) + "_" + System.nanoTime() + "."
					+ FilenameUtils.getExtension(filename);
		}
		return filename;
	}
}
