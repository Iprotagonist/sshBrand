package com.yangpan.mybrand.controller;

import com.yangpan.mybrand.entity.Sku;
import com.yangpan.mybrand.enums.ColorEnum;
import com.yangpan.mybrand.enums.SizeEnum;
import com.yangpan.mybrand.service.ISkuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class SkuController {
    @Autowired
    ISkuService iss;

    @RequestMapping("/savSku")
    public void savSku(Sku sku){
        iss.sav(sku);
    }

    @RequestMapping("/findSkuBySku_Id/")
    @ResponseBody
    public Map  findSkuBySku_Id( Integer sku_product_id,int offset,int limit){
        int pageIndex = offset / limit;
        Map skumup = iss.findSku(sku_product_id, pageIndex, limit);
        return skumup;
    }

    @RequestMapping("/toSkuProductId/{sku_product_id}")
    public String toSkuProductId(@PathVariable("sku_product_id") Integer sku_product_id,Model model){
        Sku sku = iss.findOneSku(sku_product_id);
        model.addAttribute("sku_product_id",sku_product_id);
        model.addAttribute("sku",sku);
        model.addAttribute("ce", ColorEnum.values());
        model.addAttribute("se", SizeEnum.values());
        return "/jsp/sku/list";
    }

    @GetMapping("/skuUpdate/{sku_product_id}")
    public String skuUpdate(@PathVariable("id") Integer id, Model model){
        Sku sku = iss.findOneSku(id);
        model.addAttribute("sku",sku);
        model.addAttribute("productId", sku.getProduct().getProduct_id());
        model.addAttribute("ce", ColorEnum.values());
        return "/jsp/sku/update";
    }

    @RequestMapping(value = "/skuUpdate", method = RequestMethod.POST)
    public String updateUser(Sku sku) {
        iss.sav(sku);
        return "/jsp/Success";
    }

    @ModelAttribute
    public void findSkuOne(@RequestParam(value = "skuId",required = false)Integer id ,Model model){
        if(id!=null){
            iss.findOneSku(id);
            model.addAttribute("sku",iss.findOneSku(id));
        }
    }
    @RequestMapping("/goToSkuOne/")
    @ResponseBody
    public Sku findOne(Integer id){
        return iss.findOneSku(id);
    }
}
