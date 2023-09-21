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

package it.vrscuola.scuola.services.config;

import it.vrscuola.scuola.models.InitParamModel;
import it.vrscuola.scuola.repositories.devices.VRDeviceInitRepository;
import it.vrscuola.scuola.services.securities.ValidateCredentialService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class ReadOculusServices {

    @Value("${school.resource.conf}") // path configuration file
    String confPath;

    public List<InitParamModel> addOculus(ValidateCredentialService validateCredentialService) {
        List<InitParamModel> param = new ArrayList<>();

        try {
            BufferedReader fileReader = new BufferedReader(new FileReader(confPath + "add_oculus.conf"));
            String line;
            String mac;
            String code;
            Pattern macPattern = Pattern.compile("([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})");

            while ((line = fileReader.readLine()) != null) {

                String[] sep = line.split(",");
                mac = sep[0];
                code = sep[1];

                Matcher matcher = macPattern.matcher(mac);
                if (matcher.find()) {
                    String macAddress = matcher.group();
                    // validation code here
                    String s = validateCredentialService.generateVisorCode(mac);
                    if (code.equals(s)) {
                        InitParamModel initParamModel = new InitParamModel();
                        initParamModel.setMacAddress(macAddress);
                        initParamModel.setCode(code);
                        param.add(initParamModel);
                    }
                }
            }

            fileReader.close();

            renameFile(confPath + "add_oculus.conf", confPath + "add_oculus.conf.done");

        } catch (IOException ex) {
            ex.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return param;
    }

    public List<InitParamModel> changeOculus(VRDeviceInitRepository iRepository) {
        List<InitParamModel> param = new ArrayList<>();

        try {
            BufferedReader fileReader = new BufferedReader(new FileReader(confPath + "change_oculus.conf"));
            String line;
            String new_mac;
            String old_mac;
            Pattern macPattern = Pattern.compile("([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})");

            while ((line = fileReader.readLine()) != null) {

                String[] sep = line.split(",");
                old_mac = sep[0];
                new_mac = sep[1];


                Matcher matcher = macPattern.matcher(new_mac);
                if (matcher.find()) {
                    InitParamModel initParamModel = new InitParamModel();
                    initParamModel.setMacAddress(new_mac);
                    initParamModel.setOldMacAddress(old_mac);
                    initParamModel.setCode(iRepository.codeByMacAddress(old_mac));
                    param.add(initParamModel);
                }
            }

            fileReader.close();

            renameFile(confPath + "change_oculus.conf", confPath + "change_oculus.conf.done");

        } catch (IOException ex) {
            ex.printStackTrace();
        }

        return param;
    }

    public boolean existAddFile() {
        return checkFileExists(confPath + "add_oculus.conf");
    }

    public boolean existUpdateFile() {
        return checkFileExists(confPath + "change_oculus.conf");
    }


    private boolean checkFileExists(String filePath) {
        File file = new File(filePath);
        return file.exists();
    }


    private void renameFile(String oldName, String newName) {
        File oldFile = new File(oldName);
        File newFile = new File(newName);
        if (oldFile.exists()) {
            oldFile.renameTo(newFile);
        }
    }

}
