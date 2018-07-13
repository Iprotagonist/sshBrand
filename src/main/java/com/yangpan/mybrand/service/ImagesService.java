package com.yangpan.mybrand.service;

import com.yangpan.mybrand.dao.ImagesRepostory;
import com.yangpan.mybrand.entity.Images;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ImagesService implements IImaesService {
    @Autowired
    ImagesRepostory ir;
    @Override
    public List<Images> findImagesByProduct_Product_id(Integer productId) {
        return ir.findImagesByProduct_Product_id(productId);
    }
}
