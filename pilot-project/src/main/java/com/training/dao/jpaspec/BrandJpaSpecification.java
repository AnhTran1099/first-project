package com.training.dao.jpaspec;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.jpa.domain.Specification;

import com.training.entity.BrandEntity;

public class BrandJpaSpecification {
	
public static Specification<BrandEntity> getSearchCriteria(Map<String, Object> searchConditionsMap) {
		
		return new Specification<BrandEntity>() {
			private static final long serialVersionUID = 1L;
			
			@Override
			public Predicate toPredicate(Root<BrandEntity> brandRoot, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
				
				List<Predicate> predicates = new ArrayList<>();
				if (searchConditionsMap != null) {
					String search = (String) searchConditionsMap.get("keyword");
					if (StringUtils.isNotEmpty(search)) {
						predicates.add(criteriaBuilder.or (
								criteriaBuilder.like(brandRoot.get("brandName"), "%" + search + "%")));	
					}
						}
				return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
			}
		};
	}
}
