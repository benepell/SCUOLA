package online.vrscuola.controllers.health;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
@RestController
public class HelloController
{
@GetMapping("/hello/{username}")
public String hello(@PathVariable String username)
{
return "Hello Test Vr Scuola" + username;
}
}
