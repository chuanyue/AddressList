//
//  CYGEditViewController.swift
//  AddressList
//
//  Created by huxianming on 16/2/2.
//  Copyright © 2016年 chuanyue. All rights reserved.
//

import UIKit

class CYGEditViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var backItem: UIBarButtonItem!
    
    var contact:ContactData?
    //var contactController:CYGContactsViewController?
    
    typealias Myclosure = (contact:ContactData)->Void
    var myclosure:Myclosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.text = contact?.name
        phoneField.text = contact?.phone
        
        //给两个文本框添加监听，只有在两个文本框都有值时，保存按钮才可用
        nameField.addTarget(self, action: "saveEnabled", forControlEvents: .EditingChanged)
        phoneField.addTarget(self, action: "saveEnabled", forControlEvents: .EditingChanged)
    }
    
    //判断保存按钮是否可用
    func saveEnabled(){
        
        saveButton.enabled = (!nameField.text!.isEmpty)&&(!phoneField.text!.isEmpty)
    }

    @IBAction func editAction(sender: AnyObject) {
        if editItem.title == "编辑"{
            nameField.enabled = true
            phoneField.enabled = true
            phoneField.becomeFirstResponder()
            saveButton.hidden = false
            editItem.title = "取消"
            backItem.enabled = false
            
        }else if editItem.title == "取消"{
            nameField.enabled = false
            phoneField.enabled = false
            saveButton.hidden = true
            editItem.title = "编辑"
            backItem.enabled = true
            
            nameField.text = contact?.name
            phoneField.text = contact?.phone
        }
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        contact?.name = nameField.text
        contact?.phone = phoneField.text
        
        myclosure!(contact: contact!)
        //contactController?.tableView.reloadData()
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
