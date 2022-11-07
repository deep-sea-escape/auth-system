package com.dse.authsystem.configs

import com.dse.authsystem.services.AccountService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.crypto.password.PasswordEncoder

@EnableWebSecurity
class SecurityConfig(@Autowired private val service: AccountService,
                     @Autowired private val passwordEncoder: PasswordEncoder): WebSecurityConfigurerAdapter() {

    companion object {
        const val LOGIN_SUCCESS_URL: String = "/view/success"
    }

    override fun configure(auth: AuthenticationManagerBuilder) {
        auth
            .userDetailsService(service)
            .passwordEncoder(passwordEncoder)
    }

    override fun configure(http: HttpSecurity) {
        http.anonymous()
            .and()
            .formLogin()
            .successForwardUrl(LOGIN_SUCCESS_URL)
            .and()
            .authorizeRequests()
            .anyRequest().authenticated()
    }
}