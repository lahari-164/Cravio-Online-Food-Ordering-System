package com.cravio;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class CravioApplication {

	public static void main(String[] args) {
		SpringApplication.run(CravioApplication.class, args);
	}

	// This creates ONE reusable BCrypt hasher that we can @Autowired
	// anywhere in the project (mainly in UserService).
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}