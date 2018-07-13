package com.yangpan.mybrand.service;

import com.yangpan.mybrand.dao.SkuRepostory;
import com.yangpan.mybrand.entity.Sku;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SkuService implements ISkuService {
    @Autowired
    SkuRepostory sr;


    @Override
    public void sav(Sku sku) {
        sr.save(sku);
    }

    @Override
    public Map findSku(Integer profuctId, int pageIndex, int size) {
//    public Map findBrand(String name,String description, String imgUrl,String webSite, int sort, byte isDisplay, int pageIndex, int size) {
        PageRequest pageRequest = new PageRequest(pageIndex, size);
        Page page = sr.findAll(new Specification() {
            @Override
            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
                //封装查询条件
                List<Predicate> list = new ArrayList<>();
                list.add(criteriaBuilder.equal(root.get("product").get("product_id"),profuctId));
                Predicate[] p = new Predicate[list.size()];
                return criteriaBuilder.and(list.toArray(p));
            }
        }, pageRequest);
        Map map = new HashMap();
        map.put("total", page.getTotalElements());
        map.put("rows", page.getContent());
        return map;
    }

    @Override
    public List<Sku> findSkuByProduct_Product_id(Integer sku_Product_id) {
        return sr.findSkuByProduct_Product_id(sku_Product_id);
    }

    @Override
    public List<Sku> findSkus() {
        List<Sku> skuLists = sr.findAll();
        return skuLists;
    }

    @Override
    public Sku findOneSku(Integer skuId) {
        Sku oneSku = sr.findOne(skuId);
        return oneSku;
    }
}
