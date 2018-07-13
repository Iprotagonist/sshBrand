package com.yangpan.mybrand.dao;

import com.yangpan.mybrand.entity.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface BrandRepostory extends JpaRepository <Brand,Integer>,JpaSpecificationExecutor<Brand>{
    //固定条件查询
//    @Query("select u from User u where u.name=?1 and u.id = ?2")
//    List<Brand> findUserByNameAndSex(String name, String sex);

}
