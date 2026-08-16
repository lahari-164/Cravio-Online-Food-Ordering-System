package com.cravio.exception;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

// Keeps API endpoints returning JSON, while MVC pages render a proper
// HTML error view instead of a blank screen when something goes wrong.
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    public Object handleRuntimeException(RuntimeException ex, HttpServletRequest request) {
        if (isHtmlRequest(request)) {
            ModelAndView mav = new ModelAndView("error");
            mav.addObject("message", ex.getMessage());
            mav.addObject("status", HttpStatus.BAD_REQUEST.value());
            return mav;
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(ex.getMessage());
    }

    @ExceptionHandler(Exception.class)
    public Object handleGenericException(Exception ex, HttpServletRequest request) {
        if (isHtmlRequest(request)) {
            ModelAndView mav = new ModelAndView("error");
            mav.addObject("message", "Something went wrong. Please try again.");
            mav.addObject("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
            return mav;
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Something went wrong. Please try again.");
    }

    private boolean isHtmlRequest(HttpServletRequest request) {
        String accept = request.getHeader("Accept");
        if (accept == null) {
            return false;
        }
        return accept.contains("text/html") || accept.contains("application/xhtml+xml");
    }
}
