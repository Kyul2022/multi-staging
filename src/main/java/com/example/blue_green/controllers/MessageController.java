package com.example.blue_green.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MessageController {

    @GetMapping("/")
    public String getMessage() {
        return "Hello, Jesus is real!";
    }
}
