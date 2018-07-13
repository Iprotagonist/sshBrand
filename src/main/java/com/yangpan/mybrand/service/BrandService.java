package com.yangpan.mybrand.service;

import com.yangpan.mybrand.dao.BrandRepostory;
import com.yangpan.mybrand.entity.Brand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BrandService implements IBrandService {
    @Autowired
    BrandRepostory br;

    @Override
    public List<Brand> findAll() {
        return br.findAll();
    }

    @Override
    public Brand findOne(Integer id) {
        Brand brand = br.findOne(id);
        return brand;
    }

    @Override
    @Transactional
    public void sav(Brand brand) {
        br.save(brand);
    }

    @Override
    public Map findBrand(String name,int pageIndex, int size) {
//    public Map findBrand(String name,String description, String imgUrl,String webSite, int sort, byte isDisplay, int pageIndex, int size) {
        PageRequest pageRequest = new PageRequest(pageIndex, size);
        Page page = br.findAll(new Specification() {
            @Override
            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
                //封装查询条件
                List<Predicate> list = new ArrayList<>();
                if (name != null) {
                    //要查询name
                    list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" + name + "%"));
                }
//                if (sort <= 0) {
////                    //要查询sort
////                    list.add(criteriaBuilder.equal(root.get("sex").as(String.class), sort));
////                }
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
    @Transactional
    public void deleteBrands(String ids) {
        //split  字符串函数：按特定格式分段将一串字符串分割成字符数组
        String[] strings = ids.split(",");
        for (String i : strings) {
            br.delete(Integer.parseInt(i));
        }
    }


    //    //可以分页的查询
//    @Override
//    public Map findUsers(String name, String sex, int pageIndex, int size) {
//        PageRequest pageRequest = new PageRequest(pageIndex, size);
//        Page page = ur.findAll(new Specification() {
//            @Override
//            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
//                //封装查询条件
//                List<Predicate> list = new ArrayList<>();
//                if (!name.equals("")) {
//                    //要查询name
//                    list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" + name + "%"));
//                }
//                if (!sex.equals("")) {
//                    //要查询sex
//                    list.add(criteriaBuilder.equal(root.get("sex").as(String.class), sex));
//                }
//                Predicate[] p = new Predicate[list.size()];
//                return criteriaBuilder.and(list.toArray(p));
//            }
//        }, pageRequest);
//        Map map = new HashMap();
//        map.put("total", page.getTotalElements());
//        map.put("rows", page.getContent());
//        return map;
//    }


}
