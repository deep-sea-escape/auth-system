package com.dse.authsvc.services

import com.google.gson.JsonElement
import com.google.gson.JsonObject
import com.google.gson.JsonParser
import org.springframework.stereotype.Service
import java.io.*
import java.net.HttpURLConnection
import java.net.URL


@Service
class KakaoService {
    fun execKakaoLogin(authorizeCode: String): MutableMap<String, Any> {
        var accessToken: String = getAccessToken(authorizeCode)
        val userInfo: MutableMap<String, Any> = getUserInfo(accessToken)
        println(userInfo.toString())
        return userInfo
    }

    fun getAccessToken(authorizeCode: String): String {
        var accessToken: String = ""
        var refreshToken: String = ""
        val reqURL: String = "https://kauth.kakao.com/oauth/token"

        try {
            var url: URL = URL(reqURL)
            val conn = url.openConnection() as HttpURLConnection
            conn.requestMethod = "POST"
            conn.doOutput = true

            var bw = BufferedWriter(OutputStreamWriter(conn.outputStream))
            var sb = StringBuffer()

            sb.append("grant_type=authorization_code")
            sb.append("&client_id=f70d02498728ec87779fe9f76ed01da3");
            sb.append("&redirect_uri=http://127.0.0.1:8080/auth/kakao/signIn"); // 본인이 설정해 놓은 경로
            sb.append("&code=$authorizeCode")
            bw.write(sb.toString())
            bw.flush()

            var responseCode = conn.responseCode;

            val br = BufferedReader(InputStreamReader(conn.inputStream))
            var line: String? = ""
            var result: String? = ""
            while (br.readLine().also { line = it } != null) {
                result += line
            }

            val element: JsonElement = JsonParser.parseString(result)
            accessToken = element.getAsJsonObject().get("access_token").getAsString()
            refreshToken = element.getAsJsonObject().get("refresh_token").getAsString()

            br.close()
            bw.close()
        } catch (e: IOException) {
            e.printStackTrace()
        }

        return accessToken
    }

    fun getUserInfo(accessToken: String): MutableMap<String, Any> {
        var userInfo: MutableMap<String, Any> = HashMap()
        val reqURL = "https://kapi.kakao.com/v2/user/me"

        try {
            val url = URL(reqURL)
            val conn = url.openConnection() as HttpURLConnection
            conn.requestMethod = "GET"


            //    요청에 필요한 Header에 포함될 내용 
            conn.setRequestProperty("Authorization", "Bearer $accessToken")
            val responseCode = conn.responseCode
            val br = BufferedReader(InputStreamReader(conn.inputStream))
            var line: String? = ""
            var result: String? = ""
            while (br.readLine().also { line = it } != null) {
                result += line
            }
            val element = JsonParser.parseString(result)
            val properties: JsonObject = element.asJsonObject["properties"].asJsonObject
            val kakaoAccount: JsonObject = element.asJsonObject["kakao_account"].asJsonObject
            val nickname: String = properties.asJsonObject.get("nickname").asString
            val profileImage: String = properties.asJsonObject.get("profile_image").asString
            val email: String = kakaoAccount.asJsonObject.get("email").asString

            userInfo["nickname"] = nickname
            userInfo["email"] = email
            userInfo["profile_image"] = profileImage

        } catch (e: IOException) {
            e.printStackTrace()
        }

        return userInfo
    }
}