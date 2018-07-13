package com.yangpan.mybrand.service;

import com.yangpan.mybrand.entity.Sku;

import java.util.List;
import java.util.Map;

public interface ISkuService {
    void sav(Sku sku);
    List<Sku> findSkus();
    Sku findOneSku(Integer skuId);
    List<Sku> findSkuByProduct_Product_id(Integer sku_Product_id);

    Map findSku(Integer profuctId, int pageIndex, int size);
}
