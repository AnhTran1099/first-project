package com.training.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.training.common.constant.Constants;
import com.training.common.util.FileHelper;
import com.training.dao.IProductDAO;
import com.training.entity.ProductEntity;
import com.training.model.PagerModel;
import com.training.model.ResponseDataModel;
import com.training.service.IProductService;

@Service
@Transactional
public class ProductServiceImpl implements IProductService{
	
	private final Logger LOGGER = LoggerFactory.getLogger(getClass());
	
	@Value("${parent.folder.images.product}")
	private String productImageFolderPath;

	@Autowired
	IProductDAO productDao;
	
	@Override
	public ProductEntity findByProductId(Long productId) {
		return productDao.findByProductId(productId);
	}

	@Override
	public List<ProductEntity> getAll() {
		return productDao.findAll(Sort.by(Sort.Direction.DESC, "productId"));
	}

	@Override
	public ProductEntity findByProductName(String productName) {
		return productDao.findByProductName(productName);
	}

	@Override
	public ResponseDataModel findAllWithPagerApi(int pageNumber) {

		int responseCode = Constants.RESULT_CD_FAIL;
		String responseMsg = StringUtils.EMPTY;
		Map<String, Object> responseMap = new HashMap<>();
		try {
			Sort sortInfo = Sort.by(Sort.Direction.DESC, "productId");
			Pageable pageable = PageRequest.of(pageNumber - 1, Constants.PAGE_SIZE, sortInfo);
			Page<ProductEntity> productEntitiesPage = productDao.findAll(pageable);
			responseMap.put("productsList", productEntitiesPage.getContent());
			responseMap.put("paginationInfo", new PagerModel(pageNumber, productEntitiesPage.getTotalPages()));
			responseCode = Constants.RESULT_CD_SUCCESS;
		} catch (Exception e) {
			responseMsg = e.getMessage();
			LOGGER.error("Error when get all product: ", e);
		}
		return new ResponseDataModel(responseCode, responseMsg, responseMap);
	}

	@Override
	public ResponseDataModel addProduct(ProductEntity productEntity) {
		int responseCode = Constants.RESULT_CD_FAIL;
		String responseMsg = StringUtils.EMPTY;
		try {
			if (findByProductName(productEntity.getProductName()) != null) {
				responseMsg = "Product Name is duplicated";
				responseCode = Constants.RESULT_CD_DUPL;
			} else {
				MultipartFile[] imageFiles = productEntity.getImageFiles();
				if (imageFiles != null && imageFiles[0].getSize() > 0) {
					String imagePath = FileHelper.addNewFile(productImageFolderPath, imageFiles);
					productEntity.setImage(imagePath);
				}
				productDao.saveAndFlush(productEntity);
				responseMsg = "Product is added successfully";
				responseCode = Constants.RESULT_CD_SUCCESS;
			}
		} catch (Exception e) {
			responseMsg = "Error when adding brand";
			LOGGER.error("Error when adding brand: ", e);
		}
		return new ResponseDataModel(responseCode, responseMsg);
	}

	@Override
	public ResponseDataModel findProductById(Long productId) {
		int responseCode = Constants.RESULT_CD_FAIL;
		String responseMsg = StringUtils.EMPTY;
		ProductEntity productEntity = null;
		try {
			productEntity = productDao.findByProductId(productId);
			if (productEntity != null) {
				responseCode = Constants.RESULT_CD_SUCCESS;
			}
		} catch (Exception e) {
			responseMsg = "Error when finding product by ID";
			LOGGER.error("Error when finding product by ID: ", e);
		}
		return new ResponseDataModel(responseCode, responseMsg, productEntity);
	}

	@Override
	public ResponseDataModel updateProduct(ProductEntity productEntity) {
		int responseCode = Constants.RESULT_CD_FAIL;
		String responseMsg = StringUtils.EMPTY;
		try {
			
			ProductEntity duplicatedProduct = productDao.findByProductNameAndProductIdNot(productEntity.getProductName(), productEntity.getProductId());

			// Check if product name existed
			if (duplicatedProduct != null) {
				responseMsg = "Product Name is duplicated";
				responseCode = Constants.RESULT_CD_DUPL;
			} else {
				MultipartFile[] imageFiles = productEntity.getImageFiles();
				if (imageFiles != null && imageFiles[0].getSize() > 0) {
					String imagePath = FileHelper.editFile(productImageFolderPath, imageFiles, productEntity.getImage());
					productEntity.setImage(imagePath);
				}
				productDao.saveAndFlush(productEntity);
				responseMsg = "Product is updated successfully";
				responseCode = Constants.RESULT_CD_SUCCESS;
			}
		} catch (Exception e) {
			responseMsg = "Error when updating image";
			LOGGER.error("Errorr when updating image: ", e);
		}
		return new ResponseDataModel(responseCode, responseMsg);
	}

	@Override
	public ResponseDataModel deleteProduct(Long productId) {
		int responseCode = Constants.RESULT_CD_FAIL;
		String responseMsg = StringUtils.EMPTY;
		ProductEntity productEntity = productDao.findByProductId(productId);
		try {
			if (productEntity != null) {
				productDao.deleteById(productId);
				productDao.flush();

				// Remove image of product from store folder
				FileHelper.deleteFile(productEntity.getImage());
				responseMsg = "Product is deleted successfully";
				responseCode = Constants.RESULT_CD_SUCCESS;
			}
		} catch(Exception e) {
			responseMsg = "Error when deleting product";
			LOGGER.error("Error when delete product: ", e);
		}
		return new ResponseDataModel(responseCode, responseMsg);
	}

	@Override
	public ResponseDataModel searchByNameAndPrice(Map<String, Object> searchConditions, int pageNumber) {
		int responseCode = Constants.RESULT_CD_FAIL;
		String responseMsg = StringUtils.EMPTY;
		Map<String, Object> responseMap = new HashMap<String, Object>();
		try { 	
			Sort sortList = Sort.by(Sort.Direction.DESC,"productId");
			Pageable pageable = PageRequest.of(pageNumber - 1, Constants.PAGE_SIZE, sortList);
			Page<ProductEntity> productEntitesPage = productDao.searchProductByNameAndPrice(
					(String) searchConditions.getOrDefault(Constants.PROP_KEY_KEYWORD, StringUtils.EMPTY),
					Double.parseDouble((String) searchConditions.getOrDefault(Constants.PROP_KEY_PRICE_FROM, "0")),
					Double.parseDouble((String) searchConditions.getOrDefault(Constants.PROP_KEY_PRICE_TO, "1000000000")),
					pageable);
			responseMap.put("productsList", productEntitesPage.getContent());
			responseMap.put("paginationInfo", new PagerModel(pageNumber, productEntitesPage.getTotalPages()));
			if ( productEntitesPage.getTotalElements() > 0) {
				responseMsg = "Show search results: " + productEntitesPage.getTotalElements() + " product";
			} else {
				responseMsg = "No result for product. Please try refining your search and go again.";
			}
			responseCode = Constants.RESULT_CD_SUCCESS;
		} catch (Exception e) {
			responseMsg = e.getMessage();
			LOGGER.error("Error when search product: ",e);
		}
		return new ResponseDataModel(responseCode, responseMsg, responseMap);
	}

}
