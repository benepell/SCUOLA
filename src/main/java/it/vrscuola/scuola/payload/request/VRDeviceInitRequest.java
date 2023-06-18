package it.vrscuola.scuola.payload.request;

import lombok.Data;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Data
public class VRDeviceInitRequest {
    private static final Logger Log = LogManager.getLogger(VRDeviceInitRequest.class.getName());

    @Size(max = 17)
    private String macAddress;

    @Size(max = 5)
    private String label;

    @Size(max = 50)
    private String code;

    @NotBlank
    @Size(max = 17)
    private String oldMacAddress;

    @Size(max = 255)
    private String note;

}
