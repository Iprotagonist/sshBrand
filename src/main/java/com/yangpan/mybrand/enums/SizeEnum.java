package com.yangpan.mybrand.enums;

public enum SizeEnum {
    M(0,"M"),L(1,"L"),XL(2,"XL"),XXL(3,"XXL")
    ;

    private Integer code;
    private String massage;

    SizeEnum(Integer code, String massage) {
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
