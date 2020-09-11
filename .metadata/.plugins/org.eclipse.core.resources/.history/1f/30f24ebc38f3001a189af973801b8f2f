package com.training.service;

import java.util.List;

import com.training.entity.BrandEntity;
import com.training.model.ResponseDataModel;

public interface IBrandService {	

	List<BrandEntity> getAll();

	BrandEntity findByBrandName(String brandName);
	
	ResponseDataModel findAllWithPagerApi(int pageNumber);

	ResponseDataModel addApi(BrandEntity brandEntity);

	ResponseDataModel findBrandByIbApi(Long brandId);

	ResponseDataModel updateApi(BrandEntity brandEntity);

	ResponseDataModel deleteApi(Long brandId);

	ResponseDataModel searchApi(String keyword, int pageNumber);

}