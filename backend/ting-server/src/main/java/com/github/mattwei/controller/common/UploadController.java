package com.github.mattwei.controller.common;

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
 *  文件上傳接口
 * @Author Matt Wei
 * @Create 2025/1/18 下午 01:42
 */

@RestController
@RequestMapping("/upload")
@Slf4j
public class UploadController {

    @Autowired
    private AliOssUtil aliOssUtil;

    @PostMapping
    public Result<String> upload(MultipartFile file){
        log.info("文件上傳: {}", file);

        try {
            // 使用 UUID 作為新的文件名
            // 原始文件名
            String originalFilename = file.getOriginalFilename();
            // 擷取原始文件名的副檔名
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            // 新文件名
            String objectName = UUID.randomUUID().toString() + extension;
            // 文件的請求路徑 (圖片網址)
            String filePath = aliOssUtil.upload(file.getBytes(), objectName);

            return Result.success(filePath);
        } catch (IOException e) {
            log.error("文件上傳失敗: {}", e);
        }

        return Result.error(MessageConstant.UPLOAD_FAILED);
    }
}
