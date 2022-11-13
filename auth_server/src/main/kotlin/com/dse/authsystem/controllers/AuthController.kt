package com.dse.authsystem.controllers

import com.dse.authsystem.domains.Account
import com.dse.authsystem.dto.AccountLoginReq
import com.dse.authsystem.dto.AccountRegisterReq
import com.dse.authsystem.services.AccountService
import org.springframework.http.ResponseEntity
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController("/auth")
class AuthController(private val accountService: AccountService, private val passwordEncoder: PasswordEncoder) {
    @PostMapping("/register")
    fun register(@RequestBody accountRegisterReq: AccountRegisterReq): ResponseEntity<Any> {
        if(!accountService.existsAccount(accountRegisterReq.email)) {
            //throw Exception(BaseResponseCode.USER_NOT_FOUND)
        }
        accountRegisterReq.password = passwordEncoder.encode(accountRegisterReq.password)
        return ResponseEntity.ok(accountService.saveAccount(accountRegisterReq))
    }

    @PostMapping("/login")
    fun login(@RequestBody accountLoginReq: AccountLoginReq): ResponseEntity<Any> {
        if(!accountService.existsAccount(accountLoginReq.email)) {
            //throw Exception(BaseResponseCode.USER_NOT_FOUND)
        }

        val account: Account = accountService.findAccount(accountLoginReq.email)

        if(!passwordEncoder.matches(accountLoginReq.password, account.password)) {
            //throw Exception(BaseResponseCode.INVALID_PASSWORD)
        }

        return ResponseEntity.ok(accountService.login(accountLoginReq))
    }


}