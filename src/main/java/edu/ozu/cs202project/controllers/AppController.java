package edu.ozu.cs202project.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AppController
{
    @GetMapping("/")
    public String index(ModelMap model)
    {
        return "index";
    }
}
