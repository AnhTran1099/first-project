package com.training.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.training.entity.UserInfoEntity;

@Repository
public interface UserDAO extends JpaRepository<UserInfoEntity, String>{
	@Query(value="SELECT u FROM UserInfoEntity u WHERE u.username= :username AND u.password = :password")
	UserInfoEntity findUser(@Param("username") String username, @Param("password") String password);
}
