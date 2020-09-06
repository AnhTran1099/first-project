package com.training.entity;

import java.sql.Date;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name = "PRODUCT")
public class ProductEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Basic(optional = false)
	@Column(name = "PRODUCT_ID")
	private Long productId;

	@Column(name = "PRODUCT_NAME")
	private String productName;

	@Column(name = "QUANTITY")
	private int quantity;

	@Column(name = "PRICE")
	private Double price;

	@Column(name = "SALE_DATE")
	private Date saleDate;

	@Column(name = "IMAGE")
	private String image;

	@Column(name = "DESCRIPTION")
	private String description;

	@JoinColumn(name = "BRAND_ID", referencedColumnName = "BRAND_ID")
	@ManyToOne(fetch = FetchType.EAGER)
	private BrandEntity brandEntity;
	
	@Transient
	private MultipartFile[] imageFiles;

	public MultipartFile[] getImageFiles() {
		return imageFiles;
	}

	public void setImageFiles(MultipartFile[] imageFiles) {
		this.imageFiles = imageFiles;
	}

	public ProductEntity() {
		}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Date getSaleDate() {
		return saleDate;
	}

	public void setSaleDate(Date saleDate) {
		this.saleDate = saleDate;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BrandEntity getBrandEntity() {
		return brandEntity;
	}

	public void setBrandEntity(BrandEntity brandEntity) {
		this.brandEntity = brandEntity;
	}
	
}
