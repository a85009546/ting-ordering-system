package com.github.mattwei.controller.customer;

import com.github.mattwei.context.BaseContext;
import com.github.mattwei.entity.AddressBook;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.AddressBookService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/20 下午 09:23
 */

@RestController
@RequestMapping("/customer/addressBook")
@Slf4j
public class AddressBookController {
    @Autowired
    private AddressBookService addressBookService;

    /**
     * 新增地址
     * @return
     */
    @PostMapping
    public Result add(@RequestBody AddressBook addressBook){
        log.info("新增地址: {}", addressBook);
        addressBookService.save(addressBook);
        return Result.success();
    }

    /**
     * 查詢當前用戶所有地址
     * @return
     */
    @GetMapping("/list")
    public Result<List<AddressBook>> list(){
        AddressBook addressBook = new AddressBook();
        addressBook.setUserId(BaseContext.getCurrentId());
        List<AddressBook> addressBookList =   addressBookService.list(addressBook);
        return Result.success(addressBookList);
    }

    /**
     * 查詢默認地址
     * @return
     */
    @GetMapping("/default")
    public Result<AddressBook> getDefault(){
        // SQL: select * from address_book where user_id = ? and is_default = 1
        AddressBook addressBook = new AddressBook();
        addressBook.setUserId(BaseContext.getCurrentId());
        addressBook.setIsDefault(1);
        List<AddressBook> list = addressBookService.list(addressBook);
        // 判斷有無默認地址
        if (list != null && list.size() > 0) {
            return Result.success(list.get(0));
        }
        return Result.error("没有查詢到默認地址");
    }

    /**
     * 修改地址
     * @param addressBook
     * @return
     */
    @PutMapping
    public Result update(@RequestBody AddressBook addressBook){
        addressBookService.update(addressBook);
        return Result.success();
    }

    /**
     * 刪除地址
     * @param id
     * @return
     */
    @DeleteMapping
    public Result delete(Long id){
        log.info("刪除地址: {}", id);
        addressBookService.deleteById(id);
        return Result.success();
    }

    /**
     * 根據id查詢地址
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public Result<AddressBook> getById(@PathVariable Long id){
        AddressBook addressBook = addressBookService.getById(id);
        return Result.success(addressBook);
    }

    /**
     * 設置默認地址
     * @param addressBook
     * @return
     */
    @PutMapping("/default")
    public Result setDefault(@RequestBody AddressBook addressBook){
        addressBookService.setDefault(addressBook);
        return Result.success();
    }
}
