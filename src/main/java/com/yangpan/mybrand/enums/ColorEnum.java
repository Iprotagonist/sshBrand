package com.yangpan.mybrand.enums;

public enum ColorEnum {
    RED(0,"红色"),BLACK(1,"黑色"),WHITE(2,"白色")
    ;
    private Integer code;
    private String massage;

    ColorEnum(Integer code, String massage) {
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
