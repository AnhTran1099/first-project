package com.training.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.training.dao.UserDAO;
import com.training.entity.UserInfoEntity;
import com.training.service.UserInfoService;

@Service
public class UserInfoServiceImpl implements UserInfoService{
	
	@Autowired
	
	UserDAO userDAO;

	@Override
	public UserInfoEntity login(String username, String password) {
		UserInfoEntity userInfoEntity = userDAO.findUser(username, password);		
		return userInfoEntity;
	}
}