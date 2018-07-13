package com.yangpan.mybrand.controller;

import com.yangpan.mybrand.entity.Brand;
import com.yangpan.mybrand.entity.Product;
import com.yangpan.mybrand.enums.ColorEnum;
import com.yangpan.mybrand.enums.FeatureEnum;
import com.yangpan.mybrand.enums.SizeEnum;
import com.yangpan.mybrand.service.BrandService;
import com.yangpan.mybrand.service.IBrandService;
import com.yangpan.mybrand.service.IProductService;
import com.yangpan.mybrand.service.ProductService;
import org.apache.tomcat.jni.Thread;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
//@RestController
public class ProductController {
    @Autowired
    IBrandService bs;
    @Autowired
    IProductService ps;

    @RequestMapping("/findAllBrands")
    public String findAllProducts(Model brands){
        brands.addAttribute("brandList",bs.findAll());
        return "/jsp/product/list";
    }
    @RequestMapping("/to_add_product")
    public String  addProduct(Model model){
        FeatureEnum[] featureEnums = FeatureEnum.values();
        model.addAttribute("featurE",featureEnums);
        model.addAttribute("colorE", ColorEnum.values());
        model.addAttribute("brandList",bs.findAll());
        model.addAttribute("sizeE", SizeEnum.values());
        return "/jsp/product/add_product";
    }

    @RequestMapping(value = "/sav_product", method = RequestMethod.POST)
    public String  productSav(Product product, MultipartFile imgUrl, HttpSession session){
        boolean empty = imgUrl.isEmpty();
        if (!empty) {
            String filename = imgUrl.getOriginalFilename();
            product.setImgUrl(filename);//设置product中图片名，为了保存图片名到数据库
            //上传目录的路径
            String path = session.getServletContext().getRealPath("/upload");
            //根据上传目录的路径创建一个file(目录)
            File targetDir = new File(path);
            if (!targetDir.exists()) {
                //创建好目录
                targetDir.mkdirs();
            }
            //创建好目标文件
            File target = new File(targetDir, filename);
            try {
                //上传
                imgUrl.transferTo(target);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        System.out.println(product.getBrand());

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String format = simpleDateFormat.format(new Date());
        for(int i = 0;i < 4 ; i++)
            format+=(int)(Math.random() * 10);
        product.setNo(format);
        product.setCreateTime(new Date());
        ps.sav(product);
        return "/jsp/product/list";
    }

    //分页查询
    @GetMapping("/products")
    @ResponseBody
    public Map list(String name, Integer brandId,int offset, int limit) {
//    public Map list(String name,String description, String imgUrl,String webSite, int sort, byte isDisplay, int offset, int limit) {
        int pageIndex = offset / limit;
        Map map =ps.findProduct(name,brandId,pageIndex,limit);
//        Map map =bs.findBrand(name,description,imgUrl,webSite,sort,isDisplay,pageIndex,limit);
        return map;
    }


    @RequestMapping(value = "/delete_product", method = RequestMethod.GET)
    @ResponseBody
    public Map deleteBrand(String ids) {
        Map map = new HashMap();
        try {
            ps.deleteProduct(ids);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
        }
        return map;
    }

}

class MyThread extends java.lang.Thread{
    MultipartFile imgUrl;
    HttpSession session;
    public MyThread(MultipartFile imgUrl, HttpSession session) {
        this.imgUrl = imgUrl;
        this.session = session;
    }

    @Override
    public void run() {
        boolean empty = imgUrl.isEmpty();
        if (!empty) {
            String filename = imgUrl.getOriginalFilename();
            //上传目录的路径
            String path = session.getServletContext().getRealPath("/aa");
            //根据上传目录的路径创建一个file(目录)
            File targetFile = new File(path);
            if (!targetFile.exists()) {
                //创建好目录
                targetFile.mkdirs();
            }
            //创建好目标文件
            File target = new File(targetFile, filename);
            try {
                //上传
                imgUrl.transferTo(target);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

