package com.example.service;

import com.example.entity.Url;
import com.example.mapper.UrlMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UrlService {

    @Autowired
    private UrlMapper urlMapper;

    public void saveUrl(Url url) {
        urlMapper.saveUrl(url);
    }

    public void deleteUrlById(Integer id) {
        urlMapper.deleteUrlById(id);
    }

    public void updateUrl(Url url) {
        urlMapper.updateUrl(url);
    }

    public List<Url> getAllUrls() {
        return urlMapper.getAllUrls();
    }

    public Url findByLongUrl(String longUrl) {
        return urlMapper.findByLongUrl(longUrl);
    }

    public Url findByDwzKey(String dwzKey) {
        return urlMapper.findByDwzKey(dwzKey);
    }
    public List<Url> findByUserId(Integer userId) {
        return urlMapper.findByUserId(userId);
    }

    public List<Url> getPageUrls(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return urlMapper.getPageUrls(offset, pageSize);
    }
}
