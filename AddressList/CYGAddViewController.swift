//
//  CYGAddViewController.swift
//  AddressList
//
//  Created by huxianming on 16/2/1.
//  Copyright © 2016年 chuanyue. All rights reserved.
//

import UIKit

/*反向传值两种方法：
方法一： 1，在目标控制器中设置一个源控制器的对象属性
        2，在源控制器的跳转前的prepareForSegue方法中，获取目标控制器，并将自身赋给目标控制器的源控制器的对象属性
        3，在目标控制器的点击跳转方法中，将值传递给源控制器对象
方法二： 1，在目标控制器中建立代理协议，
        2，在源控制器的prepareForSegue方法中，让源控制器成为目标控制器的代理
        3，在源控制器中实现代理方法，处理数据
        4，在目标控制器的跳转方法中，调用代理的方法，并将值作为参数传递给方法
*/

//MARK:- 定义代理协议
protocol CYGAddViewControllerDelegate{
    func didClickSaveButton(addViewController:CYGAddViewController,clickSaveButtonWithContact contact:ContactData)
}

class CYGAddViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var delegate:CYGAddViewControllerDelegate?
    
    //var contactController: CYGContactsViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //给两个文本框添加监听，只有在两个文本框都有值时，保存按钮才可用
        nameField.addTarget(self, action: "saveEnabled", forControlEvents: .EditingChanged)
        phoneField.addTarget(self, action: "saveEnabled", forControlEvents: .EditingChanged)
        
    }
    
    //判断保存按钮是否可用
    func saveEnabled(){
        
        saveButton.enabled = (!nameField.text!.isEmpty)&&(!phoneField.text!.isEmpty)
    }
    

    //进入该页面后立即激活nameField文本框
    override func viewDidAppear(animated: Bool) {
        nameField.becomeFirstResponder()
    }
    
    //MARK:- 实现传值跳转
    @IBAction func saveContact(sender: AnyObject?) {
        let name = nameField.text
        let phone = phoneField.text
        
        let contact = ContactData(name: name!, phone: phone!)

        //contactController?.contact = contact
        //调用代理方法，将contact作为参数传递
        delegate?.didClickSaveButton(self, clickSaveButtonWithContact: contact)
        //实现跳转
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
