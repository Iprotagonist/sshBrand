package com.yangpan.mybrand.dao;

import com.yangpan.mybrand.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ProductRepostory  extends JpaRepository<Product,Integer>,JpaSpecificationExecutor<Product> {
}
