package com.example.helloworld;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloWorldController {

    @GetMapping("/")
    public String helloWorld(Model model) {
        model.addAttribute("message", "Welcome to the Datadog APM Hello World Application!");
        return "index"; // This maps to src/main/resources/templates/index.html
    }
}
