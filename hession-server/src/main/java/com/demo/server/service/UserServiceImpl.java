package com.demo.server.service;

import org.springframework.stereotype.Service;

/**
 * 用户服务
 *
 * @author jiangdongzhao
 * @version V1.0.0
 * @date 2020/3/17
 */
@Service
public class UserServiceImpl implements UserService {

    @Override
    public void getUser(){
        System.out.println("user_A");
    }

}
