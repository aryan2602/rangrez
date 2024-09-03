package com.rangrez;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class RangrezApplication {

	public static void main(String[] args) {
		SpringApplication.run(RangrezApplication.class, args);
	}
}

@RestController
@RequestMapping("v1/api")
class DemoController(){
	
	@GetMapping("/hello")
	public String getHello(){
		return "Hello Dhiraj from server";
	}
}