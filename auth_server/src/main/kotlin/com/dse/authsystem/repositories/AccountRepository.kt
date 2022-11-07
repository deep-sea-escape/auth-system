package com.dse.authsystem.repositories

import com.dse.authsystem.domains.Account
import org.springframework.data.jpa.repository.JpaRepository

interface AccountRepository: JpaRepository<Account, Long> {
    fun findByEmail(email: String): Account?
}