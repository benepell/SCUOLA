package online.vrscuola.controllers.devices;

import online.vrscuola.payload.request.VRDeviceInitRequest;
import online.vrscuola.payload.response.MessageResponse;
import online.vrscuola.services.devices.VRDeviceInitServiceImpl;
import online.vrscuola.utilities.MessageServiceImpl;
import online.vrscuola.utilities.UtilServiceImpl;
import online.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;


@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/initialize-devices")
public class VRDeviceInitController {

    @Value("${keycloak.credentials.secret}")
    private String code;

    @Autowired
    VRDeviceInitServiceImpl initService;

    @Autowired
    Utilities utilities;

    @SuppressWarnings("unused")
    @Autowired
    private MessageServiceImpl messageServiceImpl;

    @Autowired
    UtilServiceImpl uService;

    @PostMapping("/add")
    public ResponseEntity<?> add(@Valid VRDeviceInitRequest request) {

        if (!utilities.isValidMacAddr(request.getMacAddress())) {
            return uService.responseMsgKo(ResponseEntity.badRequest(),messageServiceImpl.getMessage("init.add.error.macaddress"));
        }

        if(code.equals(request.getCode())){
            initService.addInit(utilities,request.getMacAddress(), request.getLabel());
            return ResponseEntity.ok(new MessageResponse(messageServiceImpl.getMessage("init.add.device.activate")));
        }
        return ResponseEntity.ok(new MessageResponse(messageServiceImpl.getMessage("init.add.device.failed")));
    }

    @PostMapping("/update")
    public ResponseEntity<?> update(@Valid VRDeviceInitRequest request) {

        if (!utilities.isValidMacAddr(request.getMacAddress())) {
            return uService.responseMsgKo(ResponseEntity.badRequest(),messageServiceImpl.getMessage("init.add.error.macaddress"));
        }

        if(code.equals(request.getCode())){
            if(request.getOldMacAddress() != null){
                initService.updateInit(utilities,request.getOldMacAddress(),request.getMacAddress(), request.getLabel(), request.getNote());
                return ResponseEntity.ok(new MessageResponse(messageServiceImpl.getMessage("init.add.device.update")));
            }
        }
        return ResponseEntity.ok(new MessageResponse(messageServiceImpl.getMessage("init.add.device.failed")));
    }

}