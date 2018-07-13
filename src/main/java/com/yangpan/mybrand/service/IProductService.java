package com.yangpan.mybrand.service;

import com.yangpan.mybrand.entity.Brand;
import com.yangpan.mybrand.entity.Product;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.Map;

public interface IProductService {

    Map findProduct(String name, Integer brandId, int pageIndex, int size);

    void sav(Product product);

    void deleteProduct(String  ids);
    List<Product> findProduct();

    Page<Product> findProducts(int page,int size);
    Product findByProduct_id(Integer productId);
}
