package com.training.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@Order(value = 99)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private CustomAuthenticationProvider authProvider;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authProvider);
	}

	@Bean("authenticationManager")
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable()
			.authorizeRequests()
					.antMatchers("/","/css/**", "/js/**", "/images/**","/plugins/**","/login").permitAll()
					.antMatchers("/brand","/product").access("hasRole('ROLE_ADMIN')")
					.anyRequest().authenticated()
			.and().formLogin().loginPage("/login")
					.loginProcessingUrl("/loginAction")
					.defaultSuccessUrl("/product")
					.usernameParameter("username")
					.passwordParameter("password")
					.failureUrl("/login?error")
			.and().logout().logoutSuccessUrl("/login")
			.and().exceptionHandling().accessDeniedPage("/login");
	}
}