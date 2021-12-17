package com.project.helloworldss.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @GetMapping("/")
    public String viewIndex() {
        System.out.println("Loading Index");
        return "index";
    }
}
