package com.training.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.training.entity.ProductEntity;

@Repository
public interface IProductDAO extends JpaRepository<ProductEntity, Long> {

	ProductEntity findByProductId(Long productId);

	ProductEntity findByProductName(String productName);
	
	ProductEntity findByProductNameAndProductIdNot(String productName, Long productId);

	Page<ProductEntity> findByPriceBetween(double priceFrom, double toPrice, Pageable pageable);	

	@Query(value = "SELECT p FROM ProductEntity p JOIN BrandEntity  b ON p.brandEntity.brandId = b.brandId "
		   + " WHERE p.productName LIKE %:keyword% OR b.brandName LIKE %:keyword% ")
	Page<ProductEntity> searchProductByName(@Param("keyword") String keyword, Pageable pageable);

	@Query(value = "SELECT p FROM ProductEntity p "
			+ " JOIN BrandEntity b ON p.brandEntity.brandId = b.brandId " 
			+ " WHERE (p.productName LIKE %:keyword% OR b.brandName LIKE %:keyword%)"
			+ " AND (p.price BETWEEN :priceFrom AND :priceTo)")
	Page<ProductEntity> searchProductByNameAndPrice(@Param("keyword") String keyword,@Param("priceFrom") Double priceFrom, 
			   @Param("priceTo") Double priceTo, Pageable pageable);
}
