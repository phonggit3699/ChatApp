//
//  ListChatViewController.swift
//  ChatApp
//
//  Created by PHONG on 07/04/2022.
//

import UIKit
import Alamofire

class ListChatViewController: UIViewController {
    
    @IBOutlet weak var customSearchBarView: UIView!
    
    @IBOutlet weak var collectionContentView: UIView!
    
    @IBOutlet weak var listChatTableView: UITableView!
    
    
    var listFriend: [FriendModel] = []
    
    var cache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidAppear(_ animated: Bool) {
        cache.removeAllObjects()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupListChatTableView()
        getListFriendFromAPI()
        
    }
    
}

extension ListChatViewController {
    
    func deleteFriendById(id: String) {
        
        if let index = listFriend.firstIndex(where: { $0.id == id }) {
            self.listFriend.remove(at: index)
        }
        
        AF.request(baseURL + id, method: .delete).validate().responseDecodable(of: FriendModel.self) { (response) in
            
            if let error = response.error {
                print(error)
            }
            
            if response.value != nil {
                print("delete successfully")
            }
        }
        
        self.listChatTableView.reloadData()
    }
    
    func getListFriendFromAPI(){
        
        var items: [FriendModel] = []
        
        let fetchGroup = DispatchGroup()
        
        fetchGroup.enter()
        
        
        AF.request(baseURL).validate().responseDecodable(of: [FriendModel].self) { (response) in
            
            if let error = response.error {
                print(error)
            }
            
            if let value = response.value {
                items = value
            }
            fetchGroup.leave()
        }
        
        
        fetchGroup.notify(queue: .main) {
            self.listFriend = items
            self.listChatTableView.reloadData()
        }
    }
    
    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?) -> ()) {

        let data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData
        
        if let imageData = data {
            let image = UIImage(data: imageData as Data)
            DispatchQueue.main.async {
                completionHandler(image)
            }
            return
        }
        
        let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL.init(string: urlString)!) { (data, response, error) in
            if error == nil {
                if data != nil {
                    let image = UIImage.init(data: data!)
                    self.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            } else {
                completionHandler(nil)
            }
        }
        downloadTask.resume()
    }
    
    
    
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
        return listFriend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listChatTableView.dequeueReusableCell(withIdentifier: ChatTBVCell.className, for: indexPath) as! ChatTBVCell
        
        cell.selectionStyle = .none
        
        cell.countNewMsgView.isHidden = false
        
        if indexPath.row % 2 != 0 {
            cell.countNewMsgView.isHidden = true
        }
        
        self.imageForUrl(urlString: listFriend[indexPath.row].avatar) { image in

            if image != nil {
                cell.avatarImg.image = image
                
            }
        }
        
        cell.lblName.text = "\(listFriend[indexPath.row].name)"
        
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
            self.deleteFriendById(id: self.listFriend[indexPath.row].id)
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
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction, moreAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let chatVC = ChatViewController(nibName: "ChatView", bundle: nil)
        
        chatVC.pushName = "\(listFriend[indexPath.row].name)"
        
        chatVC.avatarImgUrl = "\(listFriend[indexPath.row].avatar)"
        
        self.navigationController?.pushViewController(chatVC, animated: true)
        
        let response: [String : Bool] = ["isHidden": true]
        
        NotificationCenter.default.post(name: Notification.Name("hiddenTabBar"), object: nil, userInfo: response)
    }
    
}


