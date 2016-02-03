//
//  CYGLoginViewController.swift
//  AddressList
//
//  Created by huxianming on 16/1/29.
//  Copyright © 2016年 chuanyue. All rights reserved.
//

import UIKit

class CYGLoginViewController: UIViewController {

    @IBOutlet weak var rememberPwdSwitch: UISwitch!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let accountKey = "account"
    private let passwordKey = "password"
    private let rememberKey = "rememberPwd"
    private let autoLoginKey = "autoLogin"
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //取出保存在Preferences中的帐户名及两个switch的状态
        nameTextField.text = userDefaults.objectForKey(accountKey) as? String
        let remb = userDefaults.boolForKey(rememberKey)
        let autoLg = userDefaults.boolForKey(autoLoginKey)
        
        //根据rememberPwdSwitch的状态设置密码框
        if remb {
            rememberPwdSwitch.on = true
            pwdTextField.text = userDefaults.objectForKey(passwordKey) as? String
        }
        
        //判断autoLoginSwitch的状态进行自动登录
        if autoLg {
            autoLoginSwitch.on = true
            
            let loginning = MBProgressHUD.showHUDAddedTo(view, animated: true)
            loginning.mode = MBProgressHUDMode.Indeterminate
            
            afterDelay(0.6, closure: {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                self.performSegueWithIdentifier("loginToContact", sender: nil)
            })
        }
        
        //给nameTextField和pwdTextField添加监听器，一旦有输入，则调用loginEnable方法判断登录按钮是否可用
        nameTextField.addTarget(self, action: "loginEnabled", forControlEvents: .EditingChanged)
        
        pwdTextField.addTarget(self, action: "loginEnabled", forControlEvents: .EditingChanged)
        
        loginEnabled()
    }
    
    //MARK:-nameTextField和pwdTextField中同时有输入，登录按钮才可以点击
    func loginEnabled(){
       
        loginButton.enabled = (!nameTextField.text!.isEmpty)&&(!pwdTextField.text!.isEmpty)
    }
    
    //rememberPwdSwitch关闭则autoLoginSwitch必须关闭
    @IBAction func rememberPwdAction(sender: AnyObject) {
        if rememberPwdSwitch.on == false {
            autoLoginSwitch.setOn(false, animated: true)
        }
        //保存rememberPwdSwitch的状态
        userDefaults.setBool(rememberPwdSwitch.on, forKey:rememberKey)
    }
    
    //autoLoginAction打开时，rememberPwdSwitch必须打开
    @IBAction func autoLoginAction(sender: AnyObject) {
        if autoLoginSwitch.on == true {
            rememberPwdSwitch.setOn(true, animated: true)
        }
        //保存autoLoginAction的状态
        userDefaults.setBool(autoLoginSwitch.on, forKey: autoLoginKey)
    }
    
    //MARK:- 判断帐户密码是否正确，如果正确就登录
    @IBAction func loginButton(sender: AnyObject) {
        if nameTextField.text == "chuanyue" && pwdTextField.text == "123456"{
            //添加蒙板
            let loginning = MBProgressHUD.showHUDAddedTo(view, animated: true)
            loginning.mode = MBProgressHUDMode.Indeterminate
            //模拟网络延迟登录
            afterDelay(0.5, closure: {
                //结束蒙板
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                //保存帐户及密码
                self.userDefaults.setObject(self.nameTextField.text, forKey: self.accountKey)
                self.userDefaults.setObject(self.pwdTextField.text, forKey: self.passwordKey)
                
                self.performSegueWithIdentifier("loginToContact", sender: nil)
            })
        }else{
            let errorHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
            errorHUD.mode = MBProgressHUDMode.Text
            errorHUD.labelText = "账号或密码错误"
            
            afterDelay(1, closure: {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            })
        }
    }
    
    //将帐户名传递到通讯录列表并显示在标题上
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let contactsController = segue.destinationViewController
        contactsController.title = nameTextField.text! + "的联系人"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

