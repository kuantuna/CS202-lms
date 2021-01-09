package edu.ozu.cs202project.controllers;

import edu.ozu.cs202project.Salter;
import edu.ozu.cs202project.services.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

import java.util.List;

@Controller
@SessionAttributes({"username", "level", "itemData"})
public class AppController
{
    @Autowired
    LoginService service;

    @Autowired
    JdbcTemplate connection;

    @GetMapping("/")
    public String rootRouteGet(ModelMap model) {
        if(model.get("username") == null) { return "redirect:/login"; }
        return "redirect:/index";
    }

    @GetMapping("/index")
    public String indexGet(ModelMap model) { return "index"; }

    @GetMapping("/register")
    public String registerGet(ModelMap model) { return "register"; }

    @PostMapping("/register")
    public String registerPost(ModelMap model, @RequestParam String name, @RequestParam String surname, @RequestParam String username, @RequestParam String password, @RequestParam String password_again)
    {
        if(!password.equals(password_again))
        {
            model.put("RegisterErrorMessage", "Passwords Don't Match");
            return "register";
        }
        if(service.usernameExist(username))
        {
            model.put("RegisterErrorMessage", "Username Already Exist");
            return "register";
        }
            password = Salter.salt(password, "CS202Project");
            service.insertRegularUser(name, surname, username, password);
            return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginGet(ModelMap model) { return "login"; }

    @PostMapping("/login")
    public String loginPost(ModelMap model, @RequestParam String username, @RequestParam String password)
    {
        password = Salter.salt(password, "CS202Project");
        if(!service.credentialsExist(username, password))
        {
            model.put("LoginErrorMessage", "Invalid Credentials");
            return "login";
        }
        int userId = service.getUserId(username);
        String privilegeLevel = service.getPrivilegeLevel(userId);
        model.put("level", privilegeLevel);
        model.put("username", username);
        return "redirect:/index";
    }

    @GetMapping("/logout")
    public String logoutGet(ModelMap model, WebRequest request, SessionStatus session)
    {
        session.setComplete();
        request.removeAttribute("username", WebRequest.SCOPE_SESSION);
        return "redirect:/login";
    }

    @GetMapping("/addpublisher")
    public String addPublisherGet(ModelMap model)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        if(service.getPrivilegeLevel(userId).equals("LibraryManager"))
        {
            return "addpublisher";
        }
        return "redirect:/index";
    }

    @PostMapping("/addpublisher")
    public String addPublisherPost(ModelMap model, @RequestParam String name, @RequestParam String username, @RequestParam String password, @RequestParam String password_again)
    {
        if (!password.equals(password_again))
        {
            model.put("addPublisherErrorMessage", "Passwords Don't Match");
            return "addpublisher";
        }
        if(service.usernameExist(username))
        {
            model.put("addPublisherErrorMessage", "Username Already Exist");
            return "addpublisher";
        }
        password = Salter.salt(password, "CS202Project");
        service.insertPublisher(name, username, password);
        return "redirect:/index";
    }

    @GetMapping("/displayborrowings")
    public String displayBorrowingsGet(ModelMap model)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        if(service.getPrivilegeLevel(userId).equals("LibraryManager")) {
            List<String[]> data = service.displayBorrowings();
            model.addAttribute("itemData",data.toArray(new String[0][8]));
            return "displayborrowings";
        }
        return "redirect:/login";
    }
}
