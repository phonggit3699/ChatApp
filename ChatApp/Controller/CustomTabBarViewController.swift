//
//  CustomTabBarViewController.swift
//  ChatApp
//
//  Created by PHONG on 07/04/2022.
//

import UIKit

class CustomTabBarViewController: UIViewController {

    @IBOutlet weak var itemTabBarView: UIView!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var customTabBar: UIStackView!
    @IBOutlet weak var btnFriend: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var lblChat: UILabel!
    @IBOutlet weak var lblFriend: UILabel!
    @IBOutlet weak var lblProfile: UILabel!
    
    var currentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customTabBar.layer.cornerRadius = 20
        setupChatVC()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let currentVC = self.currentVC {

            currentVC.view.frame = self.view.bounds
            itemTabBarView.addSubview(currentVC.view)
        
            currentVC.didMove(toParent: self)
        }
       
    }

    @IBAction func btnChatAction(_ sender: Any) {
        self.resetTabBarButton()

        setupChatVC()
    }
    @IBAction func btnFriendAction(_ sender: Any) {
        
        self.resetTabBarButton()
       
        setupFriendVC()
    }
    @IBAction func btnProfileAction(_ sender: Any) {
        self.resetTabBarButton()
      
        setupProfileVC()
    }
}
extension CustomTabBarViewController {
    
    func removeAllSubView(){
   
        for subview in itemTabBarView.subviews{
            subview.removeFromSuperview()
        }
    }
    
    func resetTabBarButton(){
        btnChat.setImage(UIImage(named: "icChatGray"), for: .normal)
        lblChat.textColor = UIColor(named: "lightGray")
        
        btnFriend.setImage(UIImage(named: "icFriendGray"), for: .normal)
        lblFriend.textColor = UIColor(named: "lightGray")
        
        btnProfile.setImage(UIImage(named: "icProfileGray"), for: .normal)
        lblProfile.textColor = UIColor(named: "lightGray")
    }
    
    func setupChatVC(){
        self.removeAllSubView()
        
        self.btnChat.setImage(UIImage(named: "icChatBlue"), for: .normal)
        self.lblChat.textColor = UIColor(named: "darkBlue")
        
        self.currentVC = ChatViewController(nibName: "ChatView", bundle: nil)
        
    }
    
    func setupProfileVC(){
        self.removeAllSubView()
        self.btnProfile.setImage(UIImage(named: "icProfileBlue"), for: .normal)
        self.lblProfile.textColor = UIColor(named: "darkBlue")
        
        self.currentVC = ProfileViewController(nibName: "ProfileView", bundle: nil)
    
    }
    
    func setupFriendVC(){
        self.removeAllSubView()
        self.btnFriend.setImage(UIImage(named: "icFriendBlue"), for: .normal)
        self.lblFriend.textColor = UIColor(named: "darkBlue")
        
        self.currentVC = FriendViewController(nibName: "FriendView", bundle: nil)
       
    }
}
