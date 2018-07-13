package com.yangpan.mybrand.service;

import com.yangpan.mybrand.dao.BrandRepostory;
import com.yangpan.mybrand.dao.ProductRepostory;
import com.yangpan.mybrand.dao.SkuRepostory;
import com.yangpan.mybrand.entity.Brand;
import com.yangpan.mybrand.entity.Product;
import com.yangpan.mybrand.entity.Sku;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.*;

@Service
public class ProductService implements IProductService {
    @Autowired
    ProductRepostory pr;
    @Autowired
    SkuRepostory sr;

    @Override
    public List<Product> findProduct() {
        return pr.findAll();
    }

    //首页分页查询
    @Override
    public Page<Product> findProducts(int page, int size) {
        PageRequest pageReques = new PageRequest((page -1),size);
        return pr.findAll(pageReques);
    }

    /**
     * 查询商品
     * @param name    商品名
     * @param brandId   品牌ID
     * @param pageIndex
     * @param size
     * @return
     */
    @Override
    public Map findProduct(String name, Integer brandId, int pageIndex, int size) {
//    public Map findBrand(String name,String description, String imgUrl,String webSite, int sort, byte isDisplay, int pageIndex, int size) {
        PageRequest pageRequest = new PageRequest(pageIndex, size);
        Page page = pr.findAll(new Specification() {
            @Override
            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
                //封装查询条件
                List<Predicate> list = new ArrayList<>();
                if (!name.equals("")) {
                    //要查询name
                    list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" + name + "%"));
                }
                if (brandId != null) {
                    //要查询brandId
                    list.add(criteriaBuilder.equal(root.get("brand").get("brand_id"), brandId));
                }
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
    public void deleteProduct(String ids) {
        //split  字符串函数：按特定格式分段将一串字符串分割成字符数组
        String[] strings = ids.split(",");
        for (String i : strings) {
            pr.delete(Integer.parseInt(i));
        }
    }

    @Override
    public void sav(Product product) {
        pr.save(product);
        //保存商品的同时保存sku
        String colors = product.getColor();
        String size = product.getSize();
        for(String c :colors.split(",")){
            for(String s :size.split(",")){
                Sku sku = new Sku();
                sku.setColor(c);
                sku.setSize(s);
                sku.setCreateTime(new Date());
                sku.setDeliveFee(10);
                sku.setLastStatus((byte) 1);
                sku.setSkuPrice(0);
                sku.setProduct(product);
                sr.save(sku);
            }
        }
    }

    @Override
    public Product findByProduct_id(Integer productId) {
        return pr.findOne(productId);
    }
}
