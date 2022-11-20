package com.dse.authsvc

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class AuthSvcApplication

fun main(args: Array<String>) {
    runApplication<AuthSvcApplication>(*args)
}
