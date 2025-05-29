package com.swp391.school_medical_management.modules.users.controllers;

import com.swp391.school_medical_management.helpers.ErrorDTO;
import com.swp391.school_medical_management.modules.users.dtos.request.LoginRequest;
import com.swp391.school_medical_management.modules.users.dtos.request.OtpVerifyRequest;
import com.swp391.school_medical_management.modules.users.dtos.response.LoginResponse;
import com.swp391.school_medical_management.modules.users.services.impl.UserService;
import jakarta.validation.Valid;
import lombok.extern.java.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("api/auth")
public class AuthController {

    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    @Autowired
    private UserService userService;

    @PostMapping("login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest request) {
        logger.info("Login request received");
        Object result = userService.login(request);

        if (result instanceof LoginResponse loginResponse) {
            return ResponseEntity.ok(loginResponse);
        }
        if (result instanceof ErrorDTO errorDTO) {
            return ResponseEntity.unprocessableEntity().body(errorDTO);
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Network Error");
    }

    @PostMapping("verify-otp")
    public ResponseEntity<?> verifyOtp(@RequestBody OtpVerifyRequest request) {
    return null;
    }

}

