package com.dse.authsvc.controllers

import com.dse.authsvc.services.KakaoService
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import java.net.URI

@RestController()
@RequestMapping("/auth")
class AuthController(private val kakaoService: KakaoService) {
    @GetMapping("/test")
    fun testConnect(): ResponseEntity<Any>{
        return ResponseEntity.ok("연결 성공")
    }

    @RequestMapping("/signIn")
    fun kakaoLogin(@RequestParam("code") code: String): ResponseEntity<Any> {
        val result: MutableMap<String, Any> = kakaoService.execKakaoLogin(code)
        val redirectUri = URI("webauthcallback://success?customToken="+ result["customToken"].toString())
        val httpHeaders = HttpHeaders()
        httpHeaders.location = redirectUri
        return ResponseEntity(httpHeaders, HttpStatus.SEE_OTHER)
    }

}