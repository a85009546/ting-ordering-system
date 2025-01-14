package com.github.mattwei.controller.admin;

import com.github.mattwei.config.OssConfiguration;
import com.github.mattwei.constant.MessageConstant;
import com.github.mattwei.result.Result;
import com.github.mattwei.utils.AliOssUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;

/**
 * Description:
 *  通用接口
 * @Author Matt Wei
 * @Create 2025/1/14 下午 08:47
 */
@RestController
@RequestMapping("/admin/common")
@Slf4j
public class CommonController {

    @Autowired
    private AliOssUtil aliOssUtil;

    @PostMapping("/upload")
    public Result<String> upload(MultipartFile file){
        log.info("文件上傳: {}", file);

        try {
            // 原始文件名
            String originalFilename = file.getOriginalFilename();
            // 擷取原始文件名的副檔名
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            // 新文件名
            String objectName = UUID.randomUUID().toString() + extension;
            // 文件的請求路徑
            String filePath = aliOssUtil.upload(file.getBytes(), objectName);
            return Result.success(filePath);
        } catch (IOException e) {
            log.error("文件上傳失敗: {}", e);
        }

        return Result.error(MessageConstant.UPLOAD_FAILED);
    }
}
