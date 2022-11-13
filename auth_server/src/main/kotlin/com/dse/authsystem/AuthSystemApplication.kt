package com.dse.authsystem

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.data.jpa.repository.config.EnableJpaAuditing

@EnableJpaAuditing
@SpringBootApplication
class AuthSystemApplication

fun main(args: Array<String>) {
    runApplication<AuthSystemApplication>(*args)
}



