//
//  ContactData.swift
//  AddressList
//
//  Created by huxianming on 16/2/1.
//  Copyright © 2016年 chuanyue. All rights reserved.
//

import Foundation

class ContactData:NSCoder{
    var name:String?
    var phone:String?
    
    init(name:String,phone:String){
        self.name = name
        self.phone = phone
    }
    
    /**
     数据归档保存时系统需要自动调用的方法
     
     - parameter aCoder: 编码器
     */
    func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(name, forKey:"name")
        aCoder.encodeObject(phone, forKey: "phone")
    }
    
    /**
     数据解档提取时系统需要自动调用的方法
     
     - parameter aDecoder: 解码器
     
     - returns: 解码后返回数据模型
     */
    func initWithCoder(aDecoder:NSCoder) -> ContactData{
        
        name = aDecoder.decodeObjectForKey("name") as? String
        phone = aDecoder.decodeObjectForKey("phone") as? String
        
        let contact = ContactData(name: name!, phone: phone!)
        return contact
    }

}