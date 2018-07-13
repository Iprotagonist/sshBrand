package com.yangpan.mybrand.controller;

import com.yangpan.mybrand.entity.Brand;
import com.yangpan.mybrand.entity.Images;
import com.yangpan.mybrand.entity.Product;
import com.yangpan.mybrand.entity.Sku;
import com.yangpan.mybrand.enums.ColorEnum;
import com.yangpan.mybrand.enums.FeatureEnum;
import com.yangpan.mybrand.enums.SizeEnum;
import com.yangpan.mybrand.service.*;
import com.yangpan.mybrand.utils.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BrandController {
    @Autowired
    IBrandService bs;
    @Autowired
    IProductService ps;
    @Autowired
    IImaesService is;
    @Autowired
    ISkuService iSkuService;
    @RequestMapping("/main")
    public String toMain() {
        return "/jsp/main";
    }
    @RequestMapping("/login")
    public String toLogin() {
        return "/jsp/login";
    }

    @RequestMapping("/mainindex")               //返回分页查询的信息
    public String toMainIndex(Model model,@RequestParam(value = "page",defaultValue = "1")Integer page) {
        model.addAttribute("brandList", bs.findAll());
//        model.addAttribute("productList",ps.findProduct());
        model.addAttribute("featureE", FeatureEnum.values());

        Page<Product> data = ps.findProducts(page, Constant.PAGE_SIZE);
        model.addAttribute("data",data);
        model.addAttribute("page",page);

        return "/front/product/list";
    }
    @RequestMapping("/magnifyingGlass/{productId}")
    public String toMagnifyingGlass(Model model,@PathVariable("productId") Integer productId){
        List<Images> images =  is.findImagesByProduct_Product_id(productId);
        Product product = ps.findByProduct_id(productId);
        String [] size = product.getSize().split(",");
        List<String > sku_size = new ArrayList<>();
        String [] skus_size = new String[4];
        skus_size[0] = "0";
        List<Sku> skuLists = iSkuService.findSkuByProduct_Product_id(productId);

        model.addAttribute("images",images);
        model.addAttribute("firstImage",images.get(0));
        model.addAttribute("colors", ColorEnum.values());
        model.addAttribute("allSize",SizeEnum.values());
        model.addAttribute("product",product);
        model.addAttribute("size",size);
        model.addAttribute("skus",skuLists);
        for(int i = 0;i < size.length ;i++){
            if(!skus_size[0].equals(skuLists.get(i).getSize())){
                skus_size[i] = skuLists.get(i).getSize();
            }else
                break;
        }
        model.addAttribute("skus_size",skus_size);
//        return  "/front/product/productDetailTest";
        return  "/front/product/productDetail";
    }

    //购物车
    @RequestMapping("/magnifyingGlass/cart")
    public String cart()
    {
        return "/front/product/cart";
    }

    /**
     * 添加数据
     *
     * @return 添加数据.jsp
     */
    @RequestMapping("/to_add_brand")
    public String addBrand() {
        return "/jsp/brand/add_brand";
    }

    /**
     * 获取添加数据界面的数据
     *
     * @param brand 数据类型
     * @return 显示所有数据的界面
     */
    @RequestMapping(value = "/sav_brand", method = RequestMethod.POST)
    public String brandSav(Brand brand) {
        bs.sav(brand);
        return "/jsp/brand/list";
    }

    /**
     * 可以分页的查询   具有较强大的查询功能
     *
     * @return
     */
    @GetMapping("/brands")
    @ResponseBody
    public Map list(String name, int offset, int limit) {
//    public Map list(String name,String description, String imgUrl,String webSite, int sort, byte isDisplay, int offset, int limit) {
        int pageIndex = offset / limit;
        Map map = bs.findBrand(name, pageIndex, limit);
//        Map map =bs.findBrand(name,description,imgUrl,webSite,sort,isDisplay,pageIndex,limit);
        return map;
    }

//    @GetMapping("/brands")
//    @ResponseBody
//    public void brandList(){
//        List<Brand> brandList = bs.findAll();
//    }

    @GetMapping("/brand/{id}")//{} 占位符
    public String getOneUser(@PathVariable("id") Integer id) {
        Brand u = bs.findOne(id);
        return "/jsp/usersupdate";
    }

    @RequestMapping(value = "/delete_brand", method = RequestMethod.GET)
    @ResponseBody
    public Map deleteBrand(String ids) {
        Map map = new HashMap();
        try {
            bs.deleteBrands(ids);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
        }
        return map;
    }

    @RequestMapping("/toBrands")
    public String toBrands() {
        return "/jsp/brand/list";
    }
}
