package com.hello.aws.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by IntelliJ IDEA
 * User: Balaji Varadharajan
 * Class/Interface/Enum Name: HelloAwsController
 * Inside the package - com.hello.aws.controllers
 * Created Date: 4/12/2020
 * Created Time: 3:47 PM
 **/
@RestController
@RequestMapping("/api/v1")
public class HelloAwsController {

    @GetMapping("/hello-aws")
    public ResponseEntity<String> getHelloMessage(){
        return new ResponseEntity<>("Hello AWS!!!", HttpStatus.OK);
    }
}
