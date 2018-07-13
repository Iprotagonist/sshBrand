package com.yangpan.mybrand.dao;

import com.yangpan.mybrand.entity.Brand;
import com.yangpan.mybrand.entity.Images;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ImagesRepostory extends JpaRepository<Images,Integer> {
    @Query("select images from Images  images where images.product.id=?1")
    List<Images> findImagesByProduct_Product_id(Integer productId);
        }
