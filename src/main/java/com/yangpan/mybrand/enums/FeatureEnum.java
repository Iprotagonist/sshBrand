package com.yangpan.mybrand.enums;

public enum FeatureEnum {
    COTTON(0,"棉"), TERYLENE(1,"涤纶");
    private Integer code;
    private String massage;
    FeatureEnum(Integer code,String massage){
        this.code = code;
        this.massage = massage;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMassage() {
        return massage;
    }

    public void setMassage(String massage) {
        this.massage = massage;
    }
}
