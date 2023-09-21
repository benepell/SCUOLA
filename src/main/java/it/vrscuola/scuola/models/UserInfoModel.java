/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package it.vrscuola.scuola.models;

public class UserInfoModel {
    private String classe;
    private String cognome;
    private String nome;
    private String sezione;
    private String argomento;
    private String durata;

    public UserInfoModel() {
    }

    public UserInfoModel(String nome, String cognome, String classe, String sezione, String argomento, String durata) {
        this.classe = classe;
        this.cognome = cognome;
        this.nome = nome;
        this.sezione = sezione;
        this.argomento = argomento;
        this.durata = durata;
    }

    public String getClasse() {
        return classe;
    }

    public void setClasse(String classe) {
        this.classe = classe;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSezione() {
        return sezione;
    }

    public void setSezione(String sezione) {
        this.sezione = sezione;
    }

    public String getArgomento() {
        return argomento;
    }

    public void setArgomento(String argomento) {
        this.argomento = argomento;
    }

    public String getDurata() {
        return durata;
    }

    public void setDurata(String durata) {
        this.durata = durata;
    }
}
