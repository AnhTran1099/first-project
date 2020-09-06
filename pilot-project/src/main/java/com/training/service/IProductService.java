package com.training.service;

import java.util.List;

import com.training.entity.ProductEntity;
import com.training.model.ResponseDataModel;

public interface IProductService {
	
	ResponseDataModel addProduct(ProductEntity productEntity);
	
	ResponseDataModel updateProduct(ProductEntity productEntity);
	
	ResponseDataModel deleteProduct(Long productId);

	ProductEntity findByProductId(Long productId);

	List<ProductEntity> getAll();

	ProductEntity findByProductName(String productName);

	ResponseDataModel findAllWithPagerApi(int pageNumber);

	ResponseDataModel findProductById(Long productId);

	ResponseDataModel searchByPrice(double priceFrom, double toPrice, int pageNumber);

	ResponseDataModel searchByName(String keyword, int pageNumber);

	ResponseDataModel searchByNameAndPrice(String keyword, int pageNumber, double priceFrom, double toPrice);

}
