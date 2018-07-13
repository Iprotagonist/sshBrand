package com.yangpan.mybrand.service;

import com.yangpan.mybrand.entity.Brand;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@SpringBootTest
public class BrandServiceTest {

    @Autowired
    BrandService br;
    @Test
    public void sav() {
        Brand brand = new Brand();
        brand.setDescription("fefefe");
        brand.setImgUrl("fefeef");
        br.sav(null);
    }
}