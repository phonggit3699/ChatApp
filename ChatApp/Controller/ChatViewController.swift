//
//  ChatViewController.swift
//  ChatApp
//
//  Created by PHONG on 08/04/2022.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var chatContentView: UIView!
    
    @IBOutlet weak var tfBackgroundView: UIView!
    
    @IBOutlet weak var btnAddPhoto: UIButton!
    
    @IBOutlet weak var messageCollectionView: UICollectionView!
    
    var tfBackgroundViewOriginY: CGFloat = 0
    
    var storeMessageCollectionViewOriginY: CGFloat = 0
    
    var pushName: String?
    
    let userName: String = "Phong"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupKeyBoard()
        
        setupCollectionView()
        
        scrollToBottomCollectionView()
    }
    @IBAction func backAction(_ sender: Any) {
        let response: [String : Bool] = ["isHidden": false]
        
        NotificationCenter.default.post(name: Notification.Name("hiddenTabBar"), object: nil, userInfo: response)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension ChatViewController {
    
    func setupKeyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        self.tfBackgroundViewOriginY = tfBackgroundView.frame.origin.y - (tfBackgroundView.frame.height + 3)
        self.storeMessageCollectionViewOriginY = messageCollectionView.frame.origin.y
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            messageCollectionView.frame.origin.y = storeMessageCollectionViewOriginY - keyboardHeight
            
            tfBackgroundView.frame.origin.y = self.tfBackgroundViewOriginY - keyboardHeight
            btnAddPhoto.frame.origin.y = self.tfBackgroundViewOriginY - keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        messageCollectionView.frame.origin.y = storeMessageCollectionViewOriginY
        
        tfBackgroundView.frame.origin.y = tfBackgroundViewOriginY
        
        btnAddPhoto.frame.origin.y  = tfBackgroundViewOriginY
        
        
    }
    
    func setupUI() {
        if self.pushName != nil {
            self.lblName.text = pushName
        }
        
        chatContentView.layer.cornerRadius = 30
        
        chatContentView.clipsToBounds = true
        
        tfBackgroundView.layer.cornerRadius = tfBackgroundView.frame.height / 2
        
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    
    
    func setupCollectionView(){
        self.messageCollectionView.delegate = self
        self.messageCollectionView.dataSource = self
        self.messageCollectionView.register(UINib(nibName: MessageCLVCell.className, bundle: nil), forCellWithReuseIdentifier: MessageCLVCell.className)
    }
    
    func scrollToBottomCollectionView(){
        self.messageCollectionView.layoutIfNeeded()
        self.messageCollectionView.scrollToLast()
    }
    
}



extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testMessage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.messageCollectionView.dequeueReusableCell(withReuseIdentifier: MessageCLVCell.className, for: indexPath) as! MessageCLVCell
    
        
        if testMessage[indexPath.row].name == self.userName {
            cell.friendImage.isHidden = true
            cell.lblMessageLeft.isHidden = true
            cell.lblTimeLeft.isHidden = true
            cell.lblMessageRight.text = testMessage[indexPath.row].message
        }
        else
        {
            cell.lblMessageRight.isHidden = true
            cell.lblTimeRight.isHidden = true
            cell.lblMessageLeft.text = testMessage[indexPath.row].message
        }

        return cell
    }
    
    
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 15
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 256, height: 0))
        if testMessage.count > 0 {
            label.text = testMessage[indexPath.row].message
        }
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        
        let cellHeight = label.frame.height + 40
        
        let size: CGSize = CGSize(width: self.messageCollectionView.frame.width, height: cellHeight)
        
        return size
    }
}

