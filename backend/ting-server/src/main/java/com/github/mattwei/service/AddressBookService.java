package com.github.mattwei.service;

import com.github.mattwei.entity.AddressBook;

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
}
