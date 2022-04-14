//
//  MessageCLVCell.swift
//  ChatApp
//
//  Created by PHONG on 12/04/2022.
//

import UIKit

class MessageCLVCell: UICollectionViewCell {

    @IBOutlet weak var lblMessageLeft: UILabel!
    
    @IBOutlet weak var lblTimeLeft: UILabel!
    
    @IBOutlet weak var lblTimeRight: UILabel!
    @IBOutlet weak var lblMessageRight: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblMessageLeft.layer.masksToBounds = true
        lblMessageLeft.layer.cornerRadius = lblMessageLeft.frame.height / 2
        
        lblMessageRight.layer.masksToBounds = true
        lblMessageRight.layer.cornerRadius = lblMessageLeft.frame.height / 2
        
    }

}

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 10
    @IBInspectable var bottomInset: CGFloat = 10
    @IBInspectable var leftInset: CGFloat = 10
    @IBInspectable var rightInset: CGFloat = 10

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}


