package com.dse.authsystem.domains

import org.hibernate.annotations.CreationTimestamp
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetails
import java.time.LocalDateTime
import java.util.Collections
import java.util.stream.Collector
import java.util.stream.Collectors
import javax.persistence.*

@Entity
class Account(name: String, email: String, m_password: String): BaseTime(), UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long? = null

    @Column(nullable = false)
    var name: String = name

    @Column(nullable = false, unique = true)
    var email: String = email

    @Column(nullable = false)
    var m_password: String = m_password

    override fun getAuthorities(): MutableSet<out GrantedAuthority>? {
        return null
    }

    override fun getPassword(): String? {
        return m_password
    }

    override fun getUsername(): String {
        return email
    }

    override fun isAccountNonExpired(): Boolean {
        return true
    }

    override fun isAccountNonLocked(): Boolean {
        return true
    }

    override fun isCredentialsNonExpired(): Boolean {
        return true
    }

    override fun isEnabled(): Boolean {
        return true
    }
}
