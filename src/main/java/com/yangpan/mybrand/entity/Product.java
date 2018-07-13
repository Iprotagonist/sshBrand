package com.yangpan.mybrand.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.annotations.JoinFormula;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "product")
public class Product {
    @Id
    @GeneratedValue
    private Integer product_id;

    private String no;//编号

    private String name;//商品名字

    private Double price;  //价格

    private Double weight;//重量

    private String isNew;//是否是新品

    private String isHot;//是否是热卖

    private String isCommend;//是否是推荐

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",locale = "zh",timezone = "GMT+8")
    private Date createTime;//上架时间

    private String isShow;//是否上架

    private String  isUpadted;//该商品是否上传过多张图片

    //brand_id
//    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)//设置为级联操作和饥渴的抓取策略
    @ManyToOne
    private Brand brand;    //品牌
//    @JoinColumn(name = "brand_id")

    private String keywords;    //关键字


    private String feature;     //材质
    private String sales;      //是否推销

    private String color;       //颜色

    private String size;        //尺寸

    private String imgUrl;      //图片URL

    private String my_desc;     //描述
    private String packageList;//包装清单

    public Integer getProduct_id() {
        return product_id;
    }

    public void setProduct_id(Integer product_id) {
        this.product_id = product_id;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public String getIsNew() {
        return isNew;
    }

    public void setIsNew(String isNew) {
        this.isNew = isNew;
    }

    public String getIsHot() {
        return isHot;
    }

    public void setIsHot(String isHot) {
        this.isHot = isHot;
    }

    public String getIsCommend() {
        return isCommend;
    }

    public void setIsCommend(String isCommend) {
        this.isCommend = isCommend;
    }

    public String getIsShow() {
        return isShow;
    }

    public void setIsShow(String isShow) {
        this.isShow = isShow;
    }

    public String getIsUpadted() {
        return isUpadted;
    }

    public void setIsUpadted(String isUpadted) {
        this.isUpadted = isUpadted;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getSales() {
        return sales;
    }

    public void setSales(String sales) {
        this.sales = sales;
    }

    public String getFeature() {
        return feature;
    }

    public void setFeature(String feature) {
        this.feature = feature;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getMy_desc() {
        return my_desc;
    }

    public void setMy_desc(String my_desc) {
        this.my_desc = my_desc;
    }

    public String getPackageList() {
        return packageList;
    }

    public void setPackageList(String packageList) {
        this.packageList = packageList;
    }

    @Override
    public String toString() {
        return "Product{" +
                "product_id=" + product_id +
                ", no='" + no + '\'' +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", weight=" + weight +
                ", isNew='" + isNew + '\'' +
                ", isHot='" + isHot + '\'' +
                ", isCommend='" + isCommend + '\'' +
                ", createTime=" + createTime +
                ", isShow='" + isShow + '\'' +
                ", isUpadted='" + isUpadted + '\'' +
                ", brand=" + brand +
                ", keywords='" + keywords + '\'' +
                ", sales='" + sales + '\'' +
                ", feature='" + feature + '\'' +
                ", color='" + color + '\'' +
                ", size='" + size + '\'' +
                ", imgUrl='" + imgUrl + '\'' +
                ", my_desc='" + my_desc + '\'' +
                ", packageList='" + packageList + '\'' +
                '}';
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}