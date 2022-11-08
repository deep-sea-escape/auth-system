package com.dse.authsystem.domains

import org.hibernate.annotations.CreationTimestamp
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.User
import java.time.LocalDateTime
import java.util.Collections
import java.util.stream.Collector
import java.util.stream.Collectors
import javax.persistence.*

@Entity
data class Account (
    @Id @GeneratedValue
    var id: Long? = null,
    var email: String,
    var password: String,

    @Enumerated(EnumType.STRING)
    @ElementCollection(fetch = FetchType.EAGER)
    var roles: MutableSet<AccountRole>,

    @CreationTimestamp
    var createDt: LocalDateTime
){
    fun getAuthorities(): User {
        return User(
            this.email,
            this.password,
            this.roles.stream().map { role -> SimpleGrantedAuthority("ROLE_$role")}.collect(Collectors.toSet())
        )
    }
}
