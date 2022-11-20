package com.dse.authsystem.services

import com.dse.authsystem.repositories.AccountRepository
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.stereotype.Service

@Service
class AccountDetailsService(private val accountRepository: AccountRepository): UserDetailsService {
    override fun loadUserByUsername(username: String): UserDetails {
        return accountRepository.findByEmail(username)
            ?: throw UsernameNotFoundException("$username Can Not Found")
    }

}