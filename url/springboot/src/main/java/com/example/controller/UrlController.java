// UrlController.java

package com.example.controller;

import com.example.common.Result;
import com.example.entity.Url;
import com.example.service.AdminService;
import com.example.service.UrlService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@RestController
public class UrlController {

    @Autowired
    private UrlService urlService;


    @Autowired
    private AdminService adminService;

    @GetMapping("/generate")
    public Result generateShortUrl(@RequestParam("url") String longUrl) {
        if (longUrl == null || longUrl.trim().isEmpty()) {
            return Result.error("201", "未传入URL");
        }

//        // 检查数据库是否已存在该长链接
//        Url existingUrl = urlService.findByLongUrl(longUrl);
//        if (existingUrl != null) {
//            return Result.success("http://localhost:9090/" + existingUrl.getDwz());
//        } else {
            // 生成短链接并保存到数据库
            String dwzKey = generateDwzKey();
            Url newUrl = new Url();
            newUrl.setLlurl(longUrl);
            newUrl.setDwz(dwzKey);
            urlService.saveUrl(newUrl);
            return Result.success("http://localhost:9090/" + dwzKey);
//        }
    }

    private String generateDwzKey() {
        // 使用UUID生成短链接
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        return uuid.substring(0, 6); // 取UUID的前6位作为短链接
    }

    @GetMapping("/{dwz}")
    public void redirectLongUrl(@PathVariable("dwz") String dwzKey, HttpServletResponse response) throws IOException {
        Url url = urlService.findByDwzKey(dwzKey);
        if (url != null) {
            response.sendRedirect(url.getLlurl());
        } else {
            // 如果找不到对应的长链接，可以返回一个404错误页面或者其他适当的处理
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @GetMapping("/userUrls")
    public Result getUserUrls(@RequestParam("id") Integer userId) {
        // 获取用户生成的短链接列表
        List<Url> adminUrls = urlService.findByUserId(userId);
        return Result.success(adminUrls);
    }

    @GetMapping("/allUrls")
    public Result getAllUrls() {
        List<Url> allUrls = urlService.getAllUrls();
        return Result.success(allUrls);
    }

    @DeleteMapping("/deleteUrl/{id}") // 根据ID删除短链接
    public Result deleteUrlById(@PathVariable("id") Integer id) {
        urlService.deleteUrlById(id);
        return Result.success("删除成功");
    }

    @PutMapping("/updateUrl")
    public Result updateUrl(@RequestBody Url url) {
        urlService.updateUrl(url);
        return Result.success("更新成功");
    }

    @GetMapping("/pageUrls")
    public Result getPageUrls(@RequestParam("page") int page, @RequestParam("pageSize") int pageSize) {
        List<Url> pageUrls = urlService.getPageUrls(page, pageSize);
        return Result.success(pageUrls);
    }

}
