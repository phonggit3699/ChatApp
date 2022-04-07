//
//  ChatViewController.swift
//  ChatApp
//
//  Created by PHONG on 07/04/2022.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var customSearchBarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customSearchBarView.layer.cornerRadius = customSearchBarView.frame.height / 2
    }

}
