package vn.edu.vinaenter.common;

import java.nio.file.AccessDeniedException;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

//AOP
@ControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(AccessDeniedException.class)
	@ResponseStatus(value = HttpStatus.FORBIDDEN) // 403
	public String handleAccessDeniedException(Exception ex) {
		return "Access denied message here";
	}

	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND) // 404
	public String handleResourceNotFoundException(Exception ex) {
		return "error/404";
	}

	/*@ExceptionHandler(value = NullPointerException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public String handleNullPointerException(Exception ex) {
		System.out.println("A null pointer exception ocurred " + ex);
		return "nullpointerExceptionPage";
	}*/

}
