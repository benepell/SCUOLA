package it.vrscuola.scuola.services.utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component
public class MessageServiceImpl implements MessageService {

    @SuppressWarnings("unused")
    private static final Logger Log = LogManager.getLogger(MessageServiceImpl.class.getName());
    @SuppressWarnings("unused")
    @Resource
    private MessageSource messageSource;

    @Override
    public String getMessage(String code) {
        return messageSource.getMessage(code, null, LocaleContextHolder.getLocale());
    }
}