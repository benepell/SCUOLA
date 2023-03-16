package online.vrscuola.controllers.resources;


import online.vrscuola.payload.request.ConnectRequest;
import online.vrscuola.payload.response.MessageResponse;
import online.vrscuola.services.connect.ConnectServiceImpl;
import online.vrscuola.utilities.MessageServiceImpl;
import online.vrscuola.utilities.UtilServiceImpl;
import online.vrscuola.utilities.Utilities;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/device")
public class ConnectController {

    @Value("${keycloak.credentials.secret}")
    private String code;

    @Autowired
    ConnectServiceImpl cService;

    @Autowired
    Utilities utilities;

    @SuppressWarnings("unused")
    @Autowired
    private MessageServiceImpl messageServiceImpl;

    @Autowired
    UtilServiceImpl uService;

    @PostMapping(value = "/username")
    public ResponseEntity<?> username(@Valid ConnectRequest request) {

        if(!cService.valid(request.getMacAddress(),request.getCode())){
            return uService.responseMsgKo(ResponseEntity.badRequest(),messageServiceImpl.getMessage("init.add.error.macaddress"));
        }

        String username = cService.viewConnect(utilities,request.getMacAddress(),request.getNote());

        return ResponseEntity.ok(new MessageResponse(username));

    }

}
