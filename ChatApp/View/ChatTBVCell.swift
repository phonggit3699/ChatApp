//
//  ChatTBVCell.swift
//  ChatApp
//
//  Created by PHONG on 08/04/2022.
//

import UIKit

class ChatTBVCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var countNewMsgView: UIView!
    
    @IBOutlet weak var lblNumberNewMsg: UILabel!

    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var lblLastMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImg.layer.cornerRadius = avatarImg.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
