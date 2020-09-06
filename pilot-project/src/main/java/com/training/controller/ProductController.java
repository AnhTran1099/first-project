package com.training.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.training.entity.ProductEntity;
import com.training.model.ResponseDataModel;
import com.training.service.IBrandService;
import com.training.service.IProductService;

@Controller
@RequestMapping(value = { "/product" })
public class ProductController {
	
	@Autowired
	IProductService productService;
	
	@Autowired
	IBrandService brandService;

	@GetMapping
	public String initPage(Model model) {
		model.addAttribute("listbrand", brandService.getAll());
		return "product-index";
	}
	
	@GetMapping("/api/find")
	@ResponseBody
	public ResponseDataModel findProductByIdApi(@RequestParam("id") Long productId) {
		return productService.findProductById(productId);
	}
	
	@GetMapping("/api/findAll/{pageNumber}")
	@ResponseBody
	public ResponseDataModel findAllWithPagerApi(@PathVariable("pageNumber") int pageNumber) {
		return productService.findAllWithPagerApi(pageNumber);
	}

	@PostMapping(value = {"/api/add"})
	@ResponseBody
	public ResponseDataModel addProduct(@ModelAttribute ProductEntity productEntity) {
		return productService.addProduct(productEntity);
	}
	
	@PostMapping(value = {"/api/update"})
	@ResponseBody
	public ResponseDataModel updateProduct(@ModelAttribute ProductEntity productEntity) {
		return productService.updateProduct(productEntity);
	}

	@DeleteMapping(value = {"/api/delete/{productId}"})
	@ResponseBody
	public ResponseDataModel deleteProduct(@PathVariable("productId") Long productId) {
		return productService.deleteProduct(productId);
	}
	
	@GetMapping(value = {"/api/searchByPrice/{priceForm}/{toPrice}/{pageNumber}"})
	@ResponseBody
	public ResponseDataModel searchByPrice(@PathVariable("priceFrom") double priceFrom, @PathVariable("toPrice") double toPrice, @PathVariable("pageNumber") int pageNumber) {
		return productService.searchByPrice(priceFrom, toPrice, pageNumber);
	}
	
	@GetMapping(value = {"/api/searchByName/{keyword}/{pageNumber}"})
	@ResponseBody
	public ResponseDataModel searchByName(@PathVariable("keyword") String keyword, @PathVariable("pageNumber") int pageNumber) {
		return productService.searchByName(keyword, pageNumber);
	}
	
	@GetMapping(value = {"/api/searchByNameAndPrice/{keyword}/{pageNumber}/{priceFrom}/{toPrice}"})
	@ResponseBody
	public ResponseDataModel searchByNameAndPrice(@PathVariable("keyword") String keyword, @PathVariable("pageNumber") int pageNumber,
											@PathVariable("priceFrom") double priceFrom, @PathVariable("toPrice") double toPrice){
		return productService.searchByNameAndPrice(keyword, pageNumber, priceFrom, toPrice);
	}
}
