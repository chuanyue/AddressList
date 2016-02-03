//
//  Fuction.swift
//  AddressList
//
//  Created by huxianming on 16/1/29.
//  Copyright © 2016年 chuanyue. All rights reserved.
//


import Foundation
import Dispatch

func afterDelay(seconds:Double, closure: () -> ()){
    let when = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    
    dispatch_after(when, dispatch_get_main_queue(), closure)
}
