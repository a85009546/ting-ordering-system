package com.github.mattwei.service.impl;

import com.github.mattwei.context.BaseContext;
import com.github.mattwei.entity.AddressBook;
import com.github.mattwei.mapper.AddressBookMapper;
import com.github.mattwei.service.AddressBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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

    /**
     * 根據用戶id查詢地址列表
     * @param addressBook
     * @return
     */
    @Override
    public List<AddressBook> list(AddressBook addressBook) {
        return addressBookMapper.list(addressBook);

    }

    /**
     * 根據id修改地址
     * @param addressBook
     */
    @Override
    public void update(AddressBook addressBook) {
        addressBook.setUserId(BaseContext.getCurrentId());
        addressBook.setIsDefault(0);
        addressBookMapper.update(addressBook);
    }

    /**
     * 根據id刪除地址
     * @param id
     */
    @Override
    public void deleteById(Long id) {
        addressBookMapper.deleteById(id);
    }

    /**
     * 根據id查詢地址
     * @param id
     * @return
     */
    @Override
    public AddressBook getById(Long id) {
        return addressBookMapper.getById(id);
    }

    /**
     * 設置默認地址
     * @param addressBook
     */
    @Override
    public void setDefault(AddressBook addressBook) {
        // 將當前用戶所有地址設為非默認
        // SQL: update address_book set is_default = 0 where user_id = ?
        addressBook.setIsDefault(0);
        addressBook.setUserId(BaseContext.getCurrentId());
        addressBookMapper.setIsDefaultByUserId(addressBook);

        // 根據地址id設為默認
        // SQL: update address_book set is_default = 1 where id = ?
        addressBook.setIsDefault(1);
        addressBookMapper.update(addressBook);
    }
}

