package com.dse.authsystem.configs

import com.dse.authsystem.domains.Account
import com.dse.authsystem.domains.AccountRole
import com.dse.authsystem.services.AccountService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.ApplicationArguments
import org.springframework.boot.ApplicationRunner
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.crypto.factory.PasswordEncoderFactories
import org.springframework.security.crypto.password.PasswordEncoder
import java.time.LocalDateTime

@Configuration
class BeanConfig {
    @Bean
    fun applicationRunner(): ApplicationRunner {
        return object : ApplicationRunner {

            @Autowired
            lateinit var accountService: AccountService

            @Throws(Exception::class)
            override fun run(args: ApplicationArguments) {
                val admin = Account(null,
                    "dse@naver.com",
                    "dse",
                    mutableSetOf(AccountRole.ADMIN, AccountRole.USER),
                    LocalDateTime.now()
                    )
                accountService.saveAccount(admin)
            }
        }
    }
}