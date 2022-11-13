package com.dse.authsystem.services

import com.dse.authsystem.domains.Account
import com.dse.authsystem.domains.AccountRole
import com.dse.authsystem.dto.AccountLoginReq
import com.dse.authsystem.dto.AccountLoginRes
import com.dse.authsystem.dto.AccountRegisterReq
import com.dse.authsystem.dto.AccountRegisterRes
import com.dse.authsystem.repositories.AccountRepository
import com.dse.authsystem.security.JwtTokenProvider
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service

@Service
class AccountService(
    private val repository: AccountRepository,
    private val jwtTokenProvider: JwtTokenProvider)
    {
        fun findAccount(email: String): Account {
            return repository.findByEmail(email)
        }

        fun existsAccount(email: String): Boolean {
            return repository.existsByEmail(email)
        }

        fun saveAccount(accountRegisterReq: AccountRegisterReq): AccountRegisterRes {
            val account = Account(accountRegisterReq.name, accountRegisterReq.email, accountRegisterReq.password)
            repository.save(account)

            return AccountRegisterRes(account.id, account.email)
        }

        fun login(accountLoginReq: AccountLoginReq): AccountLoginRes {
            var roles = findAccount(accountLoginReq.email).authorities
            val token: String = jwtTokenProvider.createToken(accountLoginReq.email, roles)

            return AccountLoginRes(HttpStatus.OK, token)
        }
}