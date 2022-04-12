//
//  ListChatViewController.swift
//  ChatApp
//
//  Created by PHONG on 07/04/2022.
//

import UIKit

class ListChatViewController: UIViewController {
    
    @IBOutlet weak var customSearchBarView: UIView!
    
    @IBOutlet weak var collectionContentView: UIView!
    
    @IBOutlet weak var listChatTableView: UITableView!
    
    var dataTest: [String] = ["Message 0", "Message 1", "Message 1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupListChatTableView()
        
    }
    
}

extension ListChatViewController {
    func setupUI() {
        self.customSearchBarView.layer.cornerRadius = customSearchBarView.frame.height / 2
        
        self.collectionContentView.layer.cornerRadius = 20
        
        self.listChatTableView.separatorStyle = .none
        
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupListChatTableView(){
        
        self.listChatTableView.delegate = self
        self.listChatTableView.dataSource = self
        
        self.listChatTableView.allowsSelection = true
        
        let nib = UINib(nibName: ChatTBVCell.className, bundle: nil)
        self.listChatTableView.register(nib, forCellReuseIdentifier: ChatTBVCell.className)
        
    }
}

extension ListChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listChatTableView.dequeueReusableCell(withIdentifier: ChatTBVCell.className, for: indexPath) as! ChatTBVCell
        
        cell.selectionStyle = .none
                
        if indexPath.row % 2 != 0 {
            cell.countNewMsgView.isHidden = true
        }
        
        cell.lblName.text = "Pham Phong \(indexPath.row + 1)"
        
        cell.lblNumberNewMsg.text = "\(indexPath.row + 1)"
        
        cell.lblLastMessage.text = "Message \(indexPath.row + 1)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        // Write action code for the trash
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("delete action ...")
            success(true)
        })
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        // Write action code for the More
        let moreAction = UIContextualAction(style: .normal, title:  "More", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("More action ...")
            success(true)
        })
        moreAction.backgroundColor = .gray
        
        
        return UISwipeActionsConfiguration(actions: [moreAction, deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        let chatVC = ChatViewController(nibName: "ChatView", bundle: nil)
        
        chatVC.pushName = "Pham Phong \(indexPath.row + 1)"

        self.navigationController?.pushViewController(chatVC, animated: true)
        
        let response: [String : Bool] = ["isHidden": true]
        
        NotificationCenter.default.post(name: Notification.Name("hiddenTabBar"), object: nil, userInfo: response)
    }

}


