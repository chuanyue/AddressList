//
//  CYGContactsViewController.swift
//  AddressList
//
//  Created by huxianming on 16/1/30.
//  Copyright © 2016年 chuanyue. All rights reserved.
//

import UIKit

class CYGContactsViewController: UITableViewController,CYGAddViewControllerDelegate {
    
    //获取contacts.plist文件的全路径
    let filePath = ((NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0])).URLByAppendingPathComponent("contacts.plist")).path
    
//    var contacts = [ContactData](){didSet{
//        tableView.reloadData()
//        NSKeyedArchiver.archiveRootObject(contacts, toFile: filePath!)
//        }
//        
//    }
    
    var contacts = [ContactData]()
    
    var contact:ContactData?
    
//    var contact:ContactData?{didSet{
//        contacts.append(contact!)
//        
//        tableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //程序启动时，将归档的数据解档并显示在tableView中
        if contacts.isEmpty{
            if (NSKeyedUnarchiver.unarchiveObjectWithFile(filePath!) == nil) {
                return
            }else{
                contacts = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath!) as! [ContactData]
                
            }
        }
        
    }
    
    
    @IBAction func backToLoginItem(sender: UIStoryboardSegue) {
        let alert = UIAlertController(title: "返回登录", message: "", preferredStyle: .ActionSheet)
        
        let doneAction = UIAlertAction(title: "确定", style: .Default, handler:{(doneAction) in
            self.navigationController?.popViewControllerAnimated(true)
        })
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        
        alert.addAction(doneAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as! CYGContactCell

        // Configure the cell...
        
        cell.contact = contacts[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
 {
        contact = contacts[indexPath.row]
        return indexPath
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        contacts.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        NSKeyedArchiver.archiveRootObject(contacts, toFile: filePath!)
    }
    
    //MARK:- CYGAddViewControllerDelegate代理方法
    func didClickSaveButton(addViewController: CYGAddViewController,clickSaveButtonWithContact contact:ContactData) {
        contacts.append(contact)
        
        NSKeyedArchiver.archiveRootObject(contacts, toFile: filePath!)
        
        tableView.reloadData()
    }
    //跳转前的准备
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addSegue"{
            let destinationCotroller = segue.destinationViewController as! CYGAddViewController
            destinationCotroller.delegate = self
        }else if segue.identifier == "editSegue"{
            let destinationCotroller = segue.destinationViewController as! CYGEditViewController
            destinationCotroller.contact = contact
            
            destinationCotroller.myclosure = {(contact:ContactData)->Void in
                NSKeyedArchiver.archiveRootObject(self.contacts, toFile: self.filePath!)
                self.tableView.reloadData()
            }
            //destinationCotroller.contactController = self
        }
    }

}
