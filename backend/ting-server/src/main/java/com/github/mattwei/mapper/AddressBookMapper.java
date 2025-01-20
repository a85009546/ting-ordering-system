package com.github.mattwei.mapper;

import com.github.mattwei.entity.AddressBook;
import org.apache.ibatis.annotations.*;

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

    /**
     * 修改地址
     * @param addressBook
     */
    void update(AddressBook addressBook);

    /**
     * 根據id刪除地址
     * @param id
     */
    @Delete("delete from address_book where id = #{id}")
    void deleteById(Long id);

    /**
     * 根據id查詢地址
     * @param id
     */
    @Select("select * from address_book where id = #{id}")
    AddressBook getById(Long id);

    /**
     * 根據用戶id修改所有地址為非默認
     * @param addressBook
     */
    @Update("update address_book set is_default = #{isDefault} where user_id = #{userId}")
    void setIsDefaultByUserId(AddressBook addressBook);
}
