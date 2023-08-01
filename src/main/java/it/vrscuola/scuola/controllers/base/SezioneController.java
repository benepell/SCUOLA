package it.vrscuola.scuola.controllers.base;

import it.vrscuola.scuola.services.ArgomentiDirService;
import it.vrscuola.scuola.services.StudentService;
import it.vrscuola.scuola.services.devices.VRDeviceManageDetailService;
import it.vrscuola.scuola.services.devices.VRDeviceManageService;
import it.vrscuola.scuola.services.devices.VRDeviceManagerOrderService;
import it.vrscuola.scuola.services.securities.KeycloakUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Arrays;

@Controller
@RequestMapping("/sezione")
public class SezioneController {

    @Autowired
    KeycloakUserService keycloakUserService;
    @Autowired
    private ArgomentiDirService argomentiDirService;

    @Autowired
    VRDeviceManagerOrderService orderService;

    @Autowired
    VRDeviceManageDetailService detailService;

    @Autowired
    StudentService studentService;

    @Autowired
    VRDeviceManageService manageService;


    @PostMapping
    public String handleClasseSelection(@RequestParam("classSelected") String classSelected,@RequestParam("sectionSelected") String sectionSelected, HttpSession session) {
        try {
            session.setAttribute("classSelected", classSelected);
            session.setAttribute("sectionSelected", sectionSelected);

            keycloakUserService.initFilterSections(classSelected,sectionSelected);
            String[] alunni = keycloakUserService.filterSectionsAllievi();
            String[] username = keycloakUserService.filterSectionsUsername();

            String classroom = session != null && session.getAttribute("classroomSelected") != null ?  session.getAttribute("classroomSelected").toString() : "";

            session.setAttribute("usernameSelected",username);
            // cancella i dati precedenti se cambia classe in connec sovrascrivi i dati precedenti
            if(username != null && username.length > 0){
                int row = studentService.deleteUserNotClass(username[0]);
                if (row > 0) {
                    String[] alu = (String[]) session.getAttribute("alunni");
                    String[] vis = manageService.allDevices(classroom);
                    studentService.cleanVisori(session);
                    if (alu != null && alu.length > 0 && vis != null && vis.length > 0 ){
                        studentService.init(Arrays.asList(alu), Arrays.asList(vis), classroom);
                    }
                }
            }

            orderService.initOrder(alunni,username,detailService);
            String[] alunniOrdinati = orderService.getAlunni();
            String[] usernameOrdinati = orderService.getUsername();
            session.setAttribute("alunni",alunniOrdinati);
            session.setAttribute("username",usernameOrdinati);
            session.setAttribute("argoments", argomentiDirService.getArgomentiAll("aula01",classSelected,sectionSelected));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/abilita-visore";
    }

}