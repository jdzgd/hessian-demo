package com.demo.server.config;

import com.demo.server.service.UserService;
import com.demo.server.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.remoting.caucho.HessianServiceExporter;
import org.springframework.remoting.support.RemoteExporter;

/**
 * 配置hessian
 * @author jiangdongzhao
 * @version V1.0.0
 * @date 2020/3/17
 */
@Configuration
public class HessianConfig {
    @Autowired
    private UserServiceImpl userService;

    @Bean("/user")
    public RemoteExporter hessianServiceExporter() {
        HessianServiceExporter exporter = new HessianServiceExporter();
        exporter.setService(userService);
        exporter.setServiceInterface(UserService.class);
        return exporter;
    }
}
