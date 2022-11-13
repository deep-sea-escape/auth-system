package com.dse.authsvc.services

import org.springframework.stereotype.Service
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL

@Service
class KakaoService {
    fun execKakaoLogin(authorize_code: String) {
        var accessToken: String = getAccessToken(authorize_code)
    }

    fun getAccessToken(authorizeCode: String): String {
        val access_Token: String = ""
        val refresh_Token: String = ""
        val reqURL: String = "https://kauth.kakao.com/oauth/token"

        try {
            var url: URL = URL(reqURL)
            val conn = url.openConnection() as HttpURLConnection

        } catch (e: IOException) {

        }

        return access_Token
    }
}