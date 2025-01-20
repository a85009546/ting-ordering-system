package com.github.mattwei.service.impl;

import com.github.mattwei.context.BaseContext;
import com.github.mattwei.entity.AddressBook;
import com.github.mattwei.mapper.AddressBookMapper;
import com.github.mattwei.service.AddressBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/20 下午 09:26
 */
@Service
public class AddressBookServiceImpl implements AddressBookService {

    @Autowired
    private AddressBookMapper addressBookMapper;
    /**
     * 新增地址
     * @param addressBook
     */
    @Override
    public void save(AddressBook addressBook) {
        // 設置當前用戶id
        addressBook.setUserId(BaseContext.getCurrentId());
        addressBook.setIsDefault(0);
        addressBookMapper.insert(addressBook);
    }
}
