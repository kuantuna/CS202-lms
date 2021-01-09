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
    // Bunun ayrıca bir class'ı açıldı ve login işlerini düzenlemek için kullanılıyor

    @Autowired
    JdbcTemplate connection;
    // Bu da connection'a erişmek için kullanılıyor

    @GetMapping("/")
    public String empty(ModelMap model) { return "index"; }
    // "/" route'una get requesti geldiği zaman index.jsp dosyasının gösterileceğini anlatıyor

    @GetMapping("/index")
    public String index(ModelMap model) { return "index"; }

    @GetMapping("/register")
    public String RegisterPage(ModelMap model) { return "register"; }

    @PostMapping("/register")
    public String handlePostRegister(ModelMap model, @RequestParam String name, @RequestParam String surname, @RequestParam String username, @RequestParam String password, @RequestParam String password_again)
    {
        if (!password.equals(password_again))
        {
            model.put("RegisterErrorMessage", "Passwords Don't Match");
            return "register";
        }
        if(service.userExist(username))
        {
            model.put("RegisterErrorMessage", "Username Already Exist");
            return "register";
        }
        else
        {
            password = Salter.salt(password, "CS202Project");
            service.insertRegularUser(name, surname, username, password);
            return "redirect:/login";
        }
    }

    @GetMapping("/login")
    public String loginPage(ModelMap model) { return "login"; }
    // "/login" route'una get requesti geldiği zaman login.jsp dosyasının gösterileceğini anlatıyor

    @PostMapping("/login")
    public String handlePostLogin(ModelMap model, @RequestParam String username, @RequestParam String password)
    {
        password = Salter.salt(password, "CS202Project");
        if(!service.validate(username, password))
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
    // "/login" route'una post requesti geldiği zaman kullanıcıdan alınan password öncelikle Salter.salt() methodu ile hashleniyor
    // Ardından if'in conditionu'nda username ve password'ün db'de olup olmadığı kontrol ediliyor eğer bulunmuyorsa
    // Oradaki hata mesajı veriliyor, eğer bulunuyorsa username variable'ının içine "username" inputunun içindeki
    // değer atanıyor.

    @GetMapping("/logout")
    public String handleLogout(ModelMap model, WebRequest request, SessionStatus session)
    {
        session.setComplete();
        request.removeAttribute("username", WebRequest.SCOPE_SESSION);
        return "redirect:/login";
    }
    // "/logout" route'una get requesti geldiği zaman session'ı sonlandırmak için ilk method çağırılıyor
    // Ardından sessionla birlikte gelen tüm değerler sıfırlanıyor
    // En son da login sayfasına redirect ediliyor (ve username null hale getirildiği için sayfanın ilk hali görüntüleniyor)
    /*
    @GetMapping("/list")
    public String list(ModelMap model)
    {
        // items Tablosu değişecek. hangi Tablo incelememiz gerekiyor.
        // item_name ve item_value değişecek.
        List<String[]> data = connection.query("SELECT * FROM items",
                (row, index) -> {
                    return new String[]{row.getString(" item_name"), row.getString("item_value")};
                });

        // itemData adında Attribute ekliyor.
        // 2 boyutlu array.
        model.addAttribute("itemData",data.toArray(new String[0][2]));

        return "/list";
    }
     */
}
