package com.yangpan.mybrand.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import java.util.Date;

/**
 * 最小销售单元
 */
@Entity
public class Sku {
    @Id
    @GeneratedValue
    private Integer id;

    private String color;
    private String size;
    @ManyToOne
    private Product product;
    private double deliveFee;//运费
    private double skuPrice;    //售价
    private double marketPrice; //市场价
    private int stockInventory;//库存
    private Date createTime;//添加时间
    private Byte lastStatus;//是否是最新
    private Byte skyType;//产品类型   1 商品    0赠品
    private int sales;  //销量

    @Override
    public String toString() {
        return "Sku{" +
                "id=" + id +
                ", color='" + color + '\'' +
                ", size='" + size + '\'' +
                ", product=" + product +
                ", deliveFee=" + deliveFee +
                ", skuPrice=" + skuPrice +
                ", marketPrice=" + marketPrice +
                ", stockInventory=" + stockInventory +
                ", createTime=" + createTime +
                ", lastStatus=" + lastStatus +
                ", skyType=" + skyType +
                ", sales=" + sales +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public double getDeliveFee() {
        return deliveFee;
    }

    public void setDeliveFee(double deliveFee) {
        this.deliveFee = deliveFee;
    }

    public double getSkuPrice() {
        return skuPrice;
    }

    public void setSkuPrice(double skuPrice) {
        this.skuPrice = skuPrice;
    }

    public double getMarketPrice() {
        return marketPrice;
    }

    public void setMarketPrice(double marketPrice) {
        this.marketPrice = marketPrice;
    }

    public int getStockInventory() {
        return stockInventory;
    }

    public void setStockInventory(int stockInventory) {
        this.stockInventory = stockInventory;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Byte getLastStatus() {
        return lastStatus;
    }

    public void setLastStatus(Byte lastStatus) {
        this.lastStatus = lastStatus;
    }

    public Byte getSkyType() {
        return skyType;
    }

    public void setSkyType(Byte skyType) {
        this.skyType = skyType;
    }

    public int getSales() {
        return sales;
    }

    public void setSales(int sales) {
        this.sales = sales;
    }
}
