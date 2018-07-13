package com.yangpan.mybrand.service;

import com.yangpan.mybrand.entity.Images;
import org.springframework.stereotype.Service;

import java.util.List;

public interface IImaesService {

    List<Images> findImagesByProduct_Product_id(Integer productId);
}
