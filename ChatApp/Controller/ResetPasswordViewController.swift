//
//  ResetPasswordViewController.swift
//  ChatApp
//
//  Created by PHONG on 11/04/2022.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnResetPass: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnResetPass.layer.cornerRadius = btnResetPass.frame.height / 2
        btnResetPass.isEnabled = false
        // Do any additional setup after loading the view.
    }

    @IBAction func tfEmailEditingChanged(_ sender: Any) {
        if txtEmail.text != "" {
            btnResetPass.isEnabled = true
            btnResetPass.backgroundColor = UIColor(named: "darkBlue")
        }
        else{
            btnResetPass.isEnabled = false
            btnResetPass.backgroundColor = UIColor(named: "lightGray")
        }
    }
    @IBAction func btnBackAction(_ sender: Any) {
        
        dismiss(animated: true)
    }
}
