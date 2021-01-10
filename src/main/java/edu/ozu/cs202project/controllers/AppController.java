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
@SessionAttributes({"username", "level", "itemData", "userId"})
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
            model.put("errorMessage", "Passwords Don't Match");
            return "register";
        }
        if(service.usernameExist(username))
        {
            model.put("errorMessage", "Username Already Exist");
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
            model.put("errorMessage", "Invalid Credentials");
            return "login";
        }
        int userId = service.getUserId(username);
        String privilegeLevel = service.getPrivilegeLevel(userId);
        model.put("userId", userId);
        model.put("level", privilegeLevel);
        model.put("username", username);
        return "redirect:/index";
    }

    @GetMapping("/logout")
    public String logoutGet(ModelMap model, WebRequest request, SessionStatus session)
    {
        session.setComplete();
        request.removeAttribute("username", WebRequest.SCOPE_SESSION);
        request.removeAttribute("userId", WebRequest.SCOPE_SESSION);
        request.removeAttribute("level", WebRequest.SCOPE_SESSION);
        request.removeAttribute("itemData", WebRequest.SCOPE_SESSION);
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
        String username_ = (String) model.get("username");
        if(username_ == null) { return "redirect:/login"; }
        int userId = service.getUserId(username_);
        if(!service.getPrivilegeLevel(userId).equals("LibraryManager")) { return "redirect:/index"; }
        if (!password.equals(password_again))
        {
            model.put("errorMessage", "Passwords Don't Match");
            return "addpublisher";
        }
        if(service.usernameExist(username))
        {
            model.put("errorMessage", "Username Already Exist");
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

    @GetMapping("/displaybookinfo")
    public String displayBookInfoGet(ModelMap model)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        List<String[]> data = service.displayBookInformation();
        model.addAttribute("itemData",data.toArray(new String[0][11]));
        return "displaybookinfo";
    }

    @GetMapping("addbook")
    public String addBookGet(ModelMap model)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        if(service.getPrivilegeLevel(userId).equals("LibraryManager")) {
            return "addbook";
        }
        return "redirect:/login";
    }

    @PostMapping("addbook")
    public String addBookPost(ModelMap model, @RequestParam String publisher_id, @RequestParam String title,
                              @RequestParam String author,  @RequestParam String topic, @RequestParam String genre)
    {
        String username_ = (String) model.get("username");
        if(username_ == null) { return "redirect:/login"; }
        int userId = service.getUserId(username_);
        if(!service.getPrivilegeLevel(userId).equals("LibraryManager")) { return "redirect:/index"; }
        if(!service.isPublisher(publisher_id))
        {
            model.put("errorMessage", "Your specified id doesn't belong to a publisher");
            return "addbook";
        }
        service.addBook(title, author, topic, genre, publisher_id);
        return "redirect:/login";
    }

    @GetMapping("addrequest")
    public String addRequestGet(ModelMap model)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        if(service.getPrivilegeLevel(userId).equals("Publisher")) {
            return "addrequest";
        }
        return "redirect:/login";
    }
}
