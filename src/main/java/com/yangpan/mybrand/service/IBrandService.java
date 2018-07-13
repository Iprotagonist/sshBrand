package com.yangpan.mybrand.service;

import com.yangpan.mybrand.entity.Brand;

import javax.persistence.ManyToOne;
import java.util.List;
import java.util.Map;

public interface IBrandService {
    List<Brand> findAll();
    Brand findOne(Integer id);
    void sav(Brand brand);
    void deleteBrands(String  ids);

    Map findBrand(String name,int pageIndex, int size);
//    Map findBrand(String name, String description, String imgUrl,String webSite,int sort,byte isDisplay,int pageIndex, int size);


}
