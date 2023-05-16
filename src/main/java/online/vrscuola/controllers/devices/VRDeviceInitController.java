package online.vrscuola.controllers.devices;

import online.vrscuola.models.InitParamModel;
import online.vrscuola.payload.response.MessageResponse;
import online.vrscuola.repositories.devices.VRDeviceInitRepository;
import online.vrscuola.services.securities.ValidateCredentialService;
import online.vrscuola.services.conf.ReadOculusServices;
import online.vrscuola.services.devices.VRDeviceInitServiceImpl;
import online.vrscuola.services.utils.MessageServiceImpl;
import online.vrscuola.services.utils.UtilServiceImpl;
import online.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/initialize-devices")
public class VRDeviceInitController {

    @Autowired
    VRDeviceInitServiceImpl initService;

    @Autowired
    Utilities utilities;

    @SuppressWarnings("unused")
    @Autowired
    private MessageServiceImpl messageServiceImpl;

    @Autowired
    ReadOculusServices rService;

    @Autowired
    ValidateCredentialService vService;

    @Autowired
    VRDeviceInitRepository repository;

    @Autowired
    UtilServiceImpl uService;

    @PostMapping("/add")
    public ResponseEntity<?> add() {

        List<InitParamModel> macs = rService.addOculus(vService);
        String note = "aggiunta visore";
        for (InitParamModel p : macs) {
            initService.addInit(utilities, p.getMacAddress(), note, p.getCode());
        }

        return ResponseEntity.ok(new MessageResponse(messageServiceImpl.getMessage("init.add.device.activate")));
    }

    @PostMapping("/update")
    public ResponseEntity<?> update() throws Exception {

        List<InitParamModel> paramModels = rService.changeOculus(repository);

        for (InitParamModel p : paramModels) {
            boolean valid = initService.valid(p.getOldMacAddress(), p.getCode());
            if (valid) {
                try {
                    String note = "modifica visore con vecchio mac: " + p.getOldMacAddress();
                    String code = vService.generateVisorCode(p.getMacAddress());
                    initService.updateInit(utilities, p.getOldMacAddress(), p.getMacAddress(), note, code);
                    return ResponseEntity.ok(new MessageResponse(messageServiceImpl.getMessage("init.add.device.update")));
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }

        }

        return ResponseEntity.ok(new MessageResponse(messageServiceImpl.getMessage("init.add.device.failed")));
    }

}