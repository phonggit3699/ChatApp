//
//  ChatViewController.swift
//  ChatApp
//
//  Created by PHONG on 07/04/2022.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var customSearchBarView: UIView!
    
    @IBOutlet weak var collectionContentView: UIView!
    
    
    @IBOutlet weak var chatCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
        
    }

}

extension ChatViewController {
    func setupUI() {
        self.customSearchBarView.layer.cornerRadius = customSearchBarView.frame.height / 2
        
        self.collectionContentView.layer.cornerRadius = 20
    }
    
    func setupCollectionView(){
        self.chatCollectionView.delegate = self
        self.chatCollectionView.dataSource = self

        
        self.chatCollectionView.register(UINib(nibName: ChatCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: ChatCollectionViewCell.className)
    }
}

extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.chatCollectionView.dequeueReusableCell(withReuseIdentifier: ChatCollectionViewCell.className, for: indexPath) as! ChatCollectionViewCell
        
        if indexPath.row % 2 != 0 {
            cell.countNewMsgView.isHidden = true
        }
        
        cell.lblNumberNewMsg.text = "\(indexPath.row + 1)"
        
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
        return 18
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        let size: CGSize = CGSize(width: self.chatCollectionView.frame.width, height: 75)
        
        return size
    }
}
