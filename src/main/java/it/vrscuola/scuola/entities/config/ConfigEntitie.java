package it.vrscuola.scuola.entities.config;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;

@Entity(name = "config")
@Data
public class ConfigEntitie implements Serializable {

    private static final long serialVersionUID = -9149515483421193087L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String name;
    private String value;

}