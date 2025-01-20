package com.github.mattwei.mapper;

import com.github.mattwei.entity.AddressBook;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/20 下午 09:28
 */
@Mapper
public interface AddressBookMapper {
    /**
     * 插入地址
     * @param addressBook
     */
    void insert(AddressBook addressBook);


    /**
     * 根據用戶id查詢地址列表
     * @param addressBook
     * @return
     */
    List<AddressBook> list(AddressBook addressBook);
}
