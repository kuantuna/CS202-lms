package edu.ozu.cs202project.controllers;

import edu.ozu.cs202project.Salter;
import edu.ozu.cs202project.services.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

@Controller
@SessionAttributes({"username", "level"})
public class AppController
{
    @Autowired
    LoginService service;

    @GetMapping("/")
    public String index(ModelMap model)
    {
        return "index";
    }

    @GetMapping("/login")
    public String loginPage(ModelMap model)
    {
        return "login";
    }

    @PostMapping("/login")
    public String handlePostLogin(ModelMap model, @RequestParam String username, @RequestParam String password)
    {
        password = Salter.salt(password, "CS202Project");
        if(!service.validate(username, password))
        {
            model.put("errorMessage", "Invalid Credentials");
            return "login";
        }
        model.put("username", username);
        return "login";
    }

    @GetMapping("/logout")
    public String handleLogout(ModelMap model, WebRequest request, SessionStatus session)
    {
        session.setComplete();
        request.removeAttribute("username", WebRequest.SCOPE_SESSION);
        return "redirect:/login";
    }
}
