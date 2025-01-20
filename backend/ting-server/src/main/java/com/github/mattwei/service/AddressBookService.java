package com.github.mattwei.service;

import com.github.mattwei.entity.AddressBook;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/20 下午 09:26
 */
public interface AddressBookService {
    /**
     * 新增地址
     * @param addressBook
     */
    void save(AddressBook addressBook);

    /**
     * 查詢當前用戶所有地址
     * @param addressBook
     * @return
     */
    List<AddressBook> list(AddressBook addressBook);

    /**
     * 修改地址
     * @param addressBook
     */
    void update(AddressBook addressBook);

    /**
     * 刪除地址
     * @param id
     */
    void deleteById(Long id);

    /**
     * 根據id查詢地址
     * @param id
     * @return
     */
    AddressBook getById(Long id);

    /**
     * 設置默認地址
     * @param addressBook
     */
    void setDefault(AddressBook addressBook);
}
