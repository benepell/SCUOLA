/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.services.config;

import org.duckdns.vrscuola.models.InitParamModel;
import org.duckdns.vrscuola.repositories.devices.VRDeviceInitRepository;
import org.duckdns.vrscuola.services.securities.ValidateCredentialService;
import org.duckdns.vrscuola.services.utils.UtilServiceImpl;
import org.duckdns.vrscuola.utilities.Constants;
import org.duckdns.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
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


    @Autowired
    UtilServiceImpl utilService;

    @Autowired
    private Utilities utilities;

    public List<InitParamModel> addOculus(ValidateCredentialService validateCredentialService) {
        List<InitParamModel> param = new ArrayList<>();

        try {
            BufferedReader fileReader = new BufferedReader(new FileReader(confPath + Constants.ADD_OCULUS_CONF));
            String line;
            String classroom;
            String label;
            String mac;
            String code;

            while ((line = fileReader.readLine()) != null) {

                String[] sep = line.split(",");
                classroom = sep[0];
                label = sep[1];
                mac = sep[2];
                code = utilService.isCodeActivation() ? sep[3] : Constants.NO_CODE;


                if (!Constants.VALIDATE_MAC_ADDRESS || utilities.isValidMacAddr(mac)) {
                    // validation code here
                    if (utilService.isCodeActivation()) {
                        String s = validateCredentialService.generateVisorCode(mac);
                        if (code.equals(s)) {
                            InitParamModel initParamModel = new InitParamModel();
                            initParamModel.setClassroom(classroom);
                            initParamModel.setLabel(label);
                            initParamModel.setMacAddress(mac);
                            initParamModel.setCode(code);
                            param.add(initParamModel);

                        }
                    } else {
                        // nocode validation
                        InitParamModel initParamModel = new InitParamModel();
                        initParamModel.setClassroom(classroom);
                        initParamModel.setLabel(label);
                        initParamModel.setMacAddress(mac);
                        initParamModel.setCode(code);
                        param.add(initParamModel);

                    }

                }
            }

            fileReader.close();

            renameFile(confPath + Constants.ADD_OCULUS_CONF, confPath + Constants.ADD_OCULUS_DONE);

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
            BufferedReader fileReader = new BufferedReader(new FileReader(confPath + Constants.CHANGE_OCULUS_CONF));
            String line;
            String classroom;
            String new_mac;
            String old_mac;

            while ((line = fileReader.readLine()) != null) {

                String[] sep = line.split(",");
                classroom = sep[0];
                old_mac = sep[1];
                new_mac = sep[2];

                if (!Constants.VALIDATE_MAC_ADDRESS || utilities.isValidMacAddr(new_mac)) {
                    InitParamModel initParamModel = new InitParamModel();
                    initParamModel.setClassroom(classroom);
                    initParamModel.setMacAddress(new_mac);
                    initParamModel.setOldMacAddress(old_mac);

                    String c_code = utilService.isCodeActivation() ? iRepository.codeByMacAddress(old_mac) : Constants.NO_CODE;
                    initParamModel.setCode(c_code);

                    param.add(initParamModel);
                }
            }

            fileReader.close();

            renameFile(confPath + Constants.CHANGE_OCULUS_CONF, confPath + Constants.CHANGE_OCULUS_DONE);

        } catch (IOException ex) {
            ex.printStackTrace();
        }

        return param;
    }

    public boolean existAddFile() {
        return checkFileExists(confPath + Constants.ADD_OCULUS_CONF);
    }

    public boolean existUpdateFile() {
        return checkFileExists(confPath + Constants.CHANGE_OCULUS_CONF);
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
