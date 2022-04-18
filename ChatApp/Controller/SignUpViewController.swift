//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by PHONG on 07/04/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet var signInView: UIView!
    
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    var isCheck: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        btnSignUp.isEnabled = false
        
        btnSignUp.layer.cornerRadius = btnSignUp.frame.height / 2
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func checkPrivacyAction(_ sender: Any) {
        isCheck = !isCheck
        
        if isCheck == false {
            btnCheck.setBackgroundImage(UIImage(named: "uncheck"), for: .normal)
        }
        else
        {
            btnCheck.setBackgroundImage(UIImage(named: "check"), for: .normal)
        }
        
        if txtUser.text != "" && txtEmail.text != "" && txtPassword.text != "" && isCheck == true{
            btnSignUp.isEnabled = true
            btnSignUp.backgroundColor = UIColor(named: "darkBlue")
        }
        else{
            btnSignUp.isEnabled = false
            btnSignUp.backgroundColor =  UIColor(named: "lightGray")
        }
    }
    
    @IBAction func tfUserEditingChanged(_ sender: Any) {
        if txtUser.text != "" && txtEmail.text != "" && txtPassword.text != "" && isCheck == true{
            btnSignUp.isEnabled = true
            btnSignUp.backgroundColor = UIColor(named: "darkBlue")
        }
        else{
            btnSignUp.isEnabled = false
            btnSignUp.backgroundColor =  UIColor(named: "lightGray")
        }
    }
    
    @IBAction func tfEmailEditingChanged(_ sender: Any) {
        if txtUser.text != "" && txtEmail.text != "" && txtPassword.text != "" && isCheck == true{
            btnSignUp.isEnabled = true
            btnSignUp.backgroundColor = UIColor(named: "darkBlue")
        }
        else{
            btnSignUp.isEnabled = false
            btnSignUp.backgroundColor =  UIColor(named: "lightGray")
        }
    }
    
    @IBAction func tfPassEditingChanged(_ sender: Any) {
        if txtUser.text != "" && txtEmail.text != "" && txtPassword.text != "" && isCheck == true{
            btnSignUp.isEnabled = true
            btnSignUp.backgroundColor = UIColor(named: "darkBlue")
        }
        else{
            btnSignUp.isEnabled = false
            btnSignUp.backgroundColor =  UIColor(named: "lightGray")
        }
    }
    @IBAction func btnAcceptPrivacy(_ sender: Any) {
    }
    
}
