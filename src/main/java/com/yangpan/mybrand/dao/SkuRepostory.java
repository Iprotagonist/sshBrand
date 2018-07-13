package com.yangpan.mybrand.dao;

import com.yangpan.mybrand.entity.Sku;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SkuRepostory extends JpaRepository<Sku,Integer>,JpaSpecificationExecutor<Sku> {

//    @Query("select images from Images  images where images.product.id=?1")
    @Query("select  sku from  Sku  sku where  sku.product.product_id=?1")
    List<Sku> findSkuByProduct_Product_id(Integer sku_Product_id);
}
