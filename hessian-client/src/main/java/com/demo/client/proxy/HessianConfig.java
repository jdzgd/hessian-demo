package com.demo.client.proxy;

import com.demo.client.service.UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.remoting.caucho.HessianProxyFactoryBean;

/**
 * @author jiangdongzhao
 * @version V1.0.0
 * @date 2020/3/17
 */
@Configuration
public class HessianConfig {

    @Bean
    public HessianProxyFactoryBean helloClient() {
        HessianProxyFactoryBean factory = new HessianProxyFactoryBean();

        factory.setServiceUrl("http://localhost:8080/user");
        factory.setServiceInterface(UserService.class);

        return factory;
    }
}
