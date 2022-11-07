package com.dse.authsystem.services

import com.dse.authsystem.domains.Account
import com.dse.authsystem.repositories.AccountRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service

@Service
class AccountService(
    @Autowired private val repository: AccountRepository,
    @Autowired private val passwordEncoder: PasswordEncoder): UserDetailsService
    {
    fun saveAccount(account: Account): Account {
        account.password = this.passwordEncoder.encode(account.password)
        return repository.save(account)
    }

    override fun loadUserByUsername(username: String): UserDetails {
        return repository.findByEmail(username)?.getAuthorities()
            ?: throw UsernameNotFoundException("$username Can Not Found")
    }
}