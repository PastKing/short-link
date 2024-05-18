// Url.java

package com.example.entity;

import java.io.Serializable;

public class Url implements Serializable {

    private Integer id;
    private String dwz;
    private String llurl;
    private String time;
    private Integer userId;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDwz() {
        return dwz;
    }

    public void setDwz(String dwz) {
        this.dwz = dwz;
    }

    public String getLlurl() {
        return llurl;
    }

    public void setLlurl(String llurl) {
        this.llurl = llurl;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}
