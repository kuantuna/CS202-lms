package edu.ozu.cs202project.controllers;

import edu.ozu.cs202project.Salter;
import edu.ozu.cs202project.services.Services;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

import java.util.List;

@Controller
@SessionAttributes({"username", "level", "itemData", "userId", "genreData", "topicData", "authorData",
        "publisherData", "bookData"})
public class AppController
{
    @Autowired
    Services service;

    @Autowired
    JdbcTemplate connection;

    @GetMapping("/")
    public String rootRouteGet(ModelMap model) {
        if(model.get("username") == null) { return "redirect:/login"; }
        return "redirect:/index";
    }

    @GetMapping("/index")
    public String indexGet(ModelMap model) {
        if(model.get("username") == null) { return "redirect:/login"; }
        return "index";
    }

    @GetMapping("/register")
    public String registerGet(ModelMap model) {
        if(model.get("username") == null) { return "register"; }
        return "redirect:/index";
    }

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
    public String loginGet(ModelMap model) {
        if(model.get("username") == null) { return "login"; }
        return "redirect:/index";
    }

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
        if(model.get("username")==null){ return "redirect:/login"; }
        session.setComplete();
        request.removeAttribute("username", WebRequest.SCOPE_SESSION);
        request.removeAttribute("userId", WebRequest.SCOPE_SESSION);
        request.removeAttribute("level", WebRequest.SCOPE_SESSION);
        request.removeAttribute("itemData", WebRequest.SCOPE_SESSION);
        request.removeAttribute("genreData", WebRequest.SCOPE_SESSION);
        request.removeAttribute("topicData", WebRequest.SCOPE_SESSION);
        request.removeAttribute("authorData", WebRequest.SCOPE_SESSION);
        request.removeAttribute("publisherData", WebRequest.SCOPE_SESSION);
        request.removeAttribute("bookData", WebRequest.SCOPE_SESSION);
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
            model.addAttribute("itemData",data.toArray(new String[0][7]));
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
        model.addAttribute("itemData",data.toArray(new String[0][14]));
        return "displaybookinfo";
    }
    // TAMAM

    @GetMapping("addbook")
    public String addBookGet(ModelMap model)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        if(service.getPrivilegeLevel(userId).equals("LibraryManager")) {
            List<String[]> publisherData = service.getPublishers();
            model.addAttribute("publisherData", publisherData.toArray(new String[0][1]));
            List<String[]> genreData = service.getGenres();
            model.addAttribute("genreData", genreData.toArray(new String[0][1]));
            List<String[]> topicData = service.getTopics();
            model.addAttribute("topicData", topicData.toArray(new String[0][1]));
            List<String[]> authorData = service.getAuthors();
            model.addAttribute("authorData", authorData.toArray(new String[0][2]));
            return "addbook";
        }
        return "redirect:/index";
    }

    @PostMapping("addbook")
    public String addBookPost(ModelMap model, @RequestParam String publisher_id, @RequestParam String title,
                              @RequestParam String publication_date,  @RequestParam String genre_id[], @RequestParam String[] topic_id,
                              @RequestParam String[] author_id)
    {
        String username_ = (String) model.get("username");
        if(username_ == null) { return "redirect:/login"; }
        int userId = service.getUserId(username_);

        if(!service.getPrivilegeLevel(userId).equals("LibraryManager")) { return "redirect:/index"; }
        String publisherId = service.getRealUserId(publisher_id);
        String fixed_date = publication_date.substring(0,10) + ' ' + publication_date.substring(11);
        service.addBook(title, publisherId, fixed_date, genre_id, topic_id, author_id);
        return "redirect:/index";
    }

    // DEVAMINA BAKCAZ


    @GetMapping("addrequest")
    public String addRequestGet(ModelMap model)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        if(service.getPrivilegeLevel(userId).equals("Publisher")) {
            List<String[]> genreData = service.getGenres();
            model.addAttribute("genreData", genreData.toArray(new String[0][1]));
            List<String[]> topicData = service.getTopics();
            model.addAttribute("topicData", topicData.toArray(new String[0][1]));
            List<String[]> authorData = service.getAuthors();
            model.addAttribute("authorData", authorData.toArray(new String[0][2]));
            return "addrequest";
        }
        return "redirect:/index";
    }

    @PostMapping("/addrequest")
    public String addRequestPost(ModelMap model, @RequestParam String title, @RequestParam String publication_date,
                                  @RequestParam String genre_id[], @RequestParam String[] topic_id,
                                 @RequestParam String[] author_id)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        String fixed_date = publication_date.substring(0,10) + ' ' + publication_date.substring(11);
        if(service.getPrivilegeLevel(userId).equals("Publisher")) {
            service.addBookRequest(title, fixed_date, genre_id, topic_id, author_id, String.valueOf(model.get("userId")));
        }
        return "redirect:/index";
    }

    @GetMapping("removerequest")
    public String removeRequestGet(ModelMap model)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        if(service.getPrivilegeLevel(userId).equals("Publisher")) {
            List<String[]> data = service.booksForRemoveRequest(String.valueOf(userId));
            model.addAttribute("itemData",data.toArray(new String[0][2]));
            return "removerequest";
        }
        return "redirect:/index";
    }

    @PostMapping("/removerequest")
    public String removeRequestPost(ModelMap model, @RequestParam String removeRequestedBook)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        if(service.getPrivilegeLevel(userId).equals("Publisher")) {
            if(removeRequestedBook == null){
                model.put("errorMessage", "There is no book to remove request");
                return "removerequest";
            }
            service.updateRemoveRequest(removeRequestedBook, String.valueOf(userId));
        }
        return "redirect:/index";
    }

    @GetMapping("/removebook")
    public String removeBookGet(ModelMap model)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        if(service.getPrivilegeLevel(userId).equals("LibraryManager"))
        {
            List<String[]> data = service.getBookIds();
            model.addAttribute("bookData",data.toArray(new String[0][1]));
            return "removebook";
        }
        return "redirect:/index";
    }

    @PostMapping("/removebook")
    public String removeBookPost(ModelMap model, @RequestParam String book_id)
    {
        String username = (String) model.get("username");
        if(username == null) { return "redirect:/login"; }
        int userId = service.getUserId(username);
        if(service.getPrivilegeLevel(userId).equals("LibraryManager"))
        {
            service.removeBook(book_id);
        }
        return "redirect:/index";
    }
}
