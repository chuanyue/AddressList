//
//  CYGContactCell.swift
//  AddressList
//
//  Created by huxianming on 16/2/1.
//  Copyright © 2016年 chuanyue. All rights reserved.
//

import UIKit

class CYGContactCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var contact:ContactData?{didSet{
        nameLabel.text = contact?.name
        phoneLabel.text = contact?.phone
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
