package com.dse.authsystem.dto

import org.springframework.http.HttpStatus

class AccountLoginRes(httpStatus: HttpStatus, token: String) {
    var httpStatus = httpStatus
    var token = token
}
