//
//  ChatViewController.swift
//  ChatApp
//
//  Created by PHONG on 08/04/2022.
//

import UIKit
import Photos
import PhotosUI

class ChatViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var chatContentView: UIView!
    
    @IBOutlet weak var tfBackgroundView: UIView!
    
    @IBOutlet weak var btnAddPhoto: UIButton!
    
    @IBOutlet weak var txtMessgae: UITextField!
    @IBOutlet weak var messageCollectionView: UICollectionView!
    
    @IBOutlet weak var btnEmojiSend: UIButton!
    @IBOutlet weak var selectionImageCollectionView: UICollectionView!
    var tfBackgroundViewOriginY: CGFloat = 0
    
    var storeMessageCollectionViewOriginY: CGFloat = 0
    
    var storeSelectionImageCollectionViewOriginY: CGFloat = 0
    
    var pushName: String?
    
    let userName: String = "Phong"
    
    var initialScrollDone: Bool = false
    
    var messages: [MessageModel] = testMessage
    
    var imageAsset: PHFetchResult<PHAsset>!
    
    var isOpenImageLibrary: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupKeyBoard()
        
        getImageAssetFromLibrary()
        
        setupCollectionView()
        
    }
    @IBAction func tfMessgaeEditingChanged(_ sender: Any) {
        
        let sendImage: UIImage = UIImage(systemName: "paperplane.circle")!
        
        sendImage.withTintColor(UIColor(named: "lightGray")!)
        
        if txtMessgae.text != "" {
            self.btnEmojiSend.setBackgroundImage(sendImage, for: .normal)
        }
        else{
            self.btnEmojiSend.setBackgroundImage(UIImage(named: "icEmoji"), for: .normal)
        }
        
    }
    @IBAction func backAction(_ sender: Any) {
        let response: [String : Bool] = ["isHidden": false]
        
        NotificationCenter.default.post(name: Notification.Name("hiddenTabBar"), object: nil, userInfo: response)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSendTextOrEmoji(_ sender: Any) {
        if let newMessage = txtMessgae.text, newMessage != "" {
            self.messages.append(MessageModel(image: "", name: self.userName, message: newMessage))
            self.messageCollectionView.reloadData()
            self.scrollToBottomCollectionView()
            self.txtMessgae.text = ""
        }
        
    }
    @IBAction func btnSelectImage(_ sender: Any) {
        self.isOpenImageLibrary = !self.isOpenImageLibrary
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: { [self] in
            if self.isOpenImageLibrary == true {
                self.selectionImageCollectionView.frame.origin.y = self.selectionImageCollectionView.frame.origin.y - 250
                
                messageCollectionView.frame.origin.y = storeMessageCollectionViewOriginY - 250
                
                tfBackgroundView.frame.origin.y = self.tfBackgroundViewOriginY - 250
                btnAddPhoto.frame.origin.y = self.tfBackgroundViewOriginY - 250
            }
            else{
                selectionImageCollectionView.frame.origin.y = storeSelectionImageCollectionViewOriginY
                messageCollectionView.frame.origin.y = storeMessageCollectionViewOriginY
                
                tfBackgroundView.frame.origin.y = tfBackgroundViewOriginY
                
                btnAddPhoto.frame.origin.y  = tfBackgroundViewOriginY
            }
        }, completion: nil)
        
    }
    override func viewDidLayoutSubviews() {
        if self.initialScrollDone == false {
            self.scrollToBottomCollectionView()
            self.initialScrollDone = true
        }
    }
    
}

extension ChatViewController {
    
    
    func getImageAssetFromLibrary() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        options.fetchLimit = 30
        
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                self.imageAsset = PHAsset.fetchAssets(with: options)
                DispatchQueue.main.async {
                    self.selectionImageCollectionView.reloadData()
                }
                
            }else {
                print("not authorized")
            }
        }
       
    }
    
    func setupKeyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        self.tfBackgroundViewOriginY = tfBackgroundView.frame.origin.y - (tfBackgroundView.frame.height + 3)
        self.storeMessageCollectionViewOriginY = messageCollectionView.frame.origin.y
        self.storeSelectionImageCollectionViewOriginY = self.selectionImageCollectionView.frame.origin.y - 50
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
        
        self.selectionImageCollectionView.delegate = self
        self.selectionImageCollectionView.dataSource = self
        self.messageCollectionView.register(UINib(nibName: MessageCLVCell.className, bundle: nil), forCellWithReuseIdentifier: MessageCLVCell.className)
        
        self.selectionImageCollectionView.register(UINib(nibName: ImageCLVCell.className, bundle: nil), forCellWithReuseIdentifier: ImageCLVCell.className)
    }
    
    func scrollToBottomCollectionView(){
        self.messageCollectionView.layoutIfNeeded()
        self.messageCollectionView.scrollToLast()
    }
    
}



extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.messageCollectionView {
            return messages.count
        }
        else{
            if imageAsset !== nil && imageAsset.count > 0 {
                return imageAsset.count
            }else{
                return 0
            }
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.messageCollectionView {
            let cell = self.messageCollectionView.dequeueReusableCell(withReuseIdentifier: MessageCLVCell.className, for: indexPath) as! MessageCLVCell
            
            cell.friendImage.isHidden = false
            cell.lblMessageLeft.isHidden = false
            cell.lblTimeLeft.isHidden = false
            cell.lblMessageRight.isHidden = false
            cell.lblTimeRight.isHidden = false
        
            if messages[indexPath.row].name == self.userName {
                cell.friendImage.isHidden = true
                cell.lblMessageLeft.isHidden = true
                cell.lblTimeLeft.isHidden = true
                cell.lblMessageRight.text = messages[indexPath.row].message
            }
            else
            {
                cell.lblMessageRight.isHidden = true
                cell.lblTimeRight.isHidden = true
                cell.lblMessageLeft.text = messages[indexPath.row].message
                
            }
    //        cell.layoutIfNeeded()
            return cell
        }
        else{
            let cell = self.selectionImageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCLVCell.className, for: indexPath) as! ImageCLVCell
            
            if let asset = self.imageAsset?.object(at: indexPath.row) {
                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 122, height: 122), contentMode: PHImageContentMode.aspectFit , options: nil) { (image, userInfo) -> Void in
                    cell.image.image = image
                }
            }
       
           
            return cell
        }
 
    }

}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 3
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.messageCollectionView {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 256, height: 0))
            if testMessage.count > 0 {
                label.text = messages[indexPath.row].message
            }
            
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.numberOfLines = 0
            label.sizeToFit()
            
            let cellHeight = label.frame.height + 40
     
            let size: CGSize = CGSize(width: self.messageCollectionView.bounds.width, height: cellHeight)
            
            return size
        }
       
        else{
            let size: CGFloat = self.messageCollectionView.frame.width / 3 - 2
            
            return CGSize(width: size, height: size)
        }
    }
}

