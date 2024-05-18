// UrlMapper.java

package com.example.mapper;

import com.example.entity.Admin;
import com.example.entity.Url;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UrlMapper {

    void saveUrl(Url url);

    void deleteUrlById(@Param("id") Integer id); // 删除方法

    void updateUrl(Url url); // 更新方法

    Url findByLongUrl(@Param("llurl") String longUrl);

    Url findByDwzKey(@Param("dwz") String dwzKey);

    List<Url> findByUserId(@Param("userId") Integer userId);

    List<Url> getAllUrls();

    List<Url> getPageUrls(@Param("offset") int offset, @Param("pageSize") int pageSize);
}
