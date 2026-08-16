package com.cravio.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

// NEW — every @ResponseBody endpoint in CravioController currently repeats
// the same "catch (RuntimeException e) { return badRequest().body(e.getMessage()) }"
// block by hand. This centralizes it so services can just throw
// RuntimeException("readable message") and every controller method
// automatically returns a clean 400 with that message as the body,
// instead of a raw stack trace / HTML error page leaking to the client.
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<?> handleRuntimeException(RuntimeException ex) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(ex.getMessage());
    }

    // Catch-all safety net for anything unexpected (NPEs, DB errors, etc.)
    // so the client never sees a raw stack trace.
    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleGenericException(Exception ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Something went wrong. Please try again.");
    }
}
