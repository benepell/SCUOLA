package it.vrscuola.scuola.services.utils;


import it.vrscuola.scuola.payload.response.MessageResponse;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

@Service
public class UtilServiceImpl implements UtilService{

    private static final Logger Log = LogManager.getLogger(UtilServiceImpl.class.getName());

    @SuppressWarnings("rawtypes")
    @Override
    public ResponseEntity responseMsgKo(ResponseEntity.BodyBuilder bodyBuilder, String msg){
        String message = msg != null ? msg : "message.general.ko";
        return bodyBuilder
                .body(new MessageResponse(message));
    }

    @SuppressWarnings("rawtypes")
    @Override
    public ResponseEntity responseMsgOk(ResponseEntity.BodyBuilder bodyBuilder, String message){
        return bodyBuilder.body(new MessageResponse(message));
    }

    @Override
    public boolean isTablet(HttpServletRequest request) {
        String userAgent = request != null && request.getHeader("User-Agent") != null
                ? request.getHeader("User-Agent") : "";

        return  userAgent.toLowerCase().contains("ipad") ||
                userAgent.toLowerCase().contains("android") || userAgent.toLowerCase().contains("tablet");

    }



}