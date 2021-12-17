package com.project.helloworldss;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class HelloworldssApplication {

	public static void main(String[] args) {
		SpringApplication.run(HelloworldssApplication.class, args);
	}

}
