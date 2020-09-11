package com.training.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.training.entity.BrandEntity;

@Repository
public interface IBrandDao extends JpaRepository<BrandEntity, Long> {

	BrandEntity findByBrandId(Long brandId);

	BrandEntity findByBrandName(String brandName);
	
	BrandEntity findByBrandNameAndBrandIdNot(String brandName, Long brandId);
	
	Page<BrandEntity> findByBrandNameLike(String brandName,Pageable pageable);
}