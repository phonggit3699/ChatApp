//
//  SignInViewController.swift
//  ChatApp
//
//  Created by PHONG on 06/04/2022.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = 26
        btnLogin.isEnabled = false
    }
    @IBAction func tfEmailEditingChanged(_ sender: Any) {
        if txtEmail.text != "" && txtPassword.text != "" {
            btnLogin.isEnabled = true
            btnLogin.backgroundColor = UIColor(named: "darkBlue")
        }
        else{
            btnLogin.isEnabled = false
            btnLogin.backgroundColor = UIColor(named: "lightGray")
        }
    }
    @IBAction func tfPassEditingChanged(_ sender: Any) {
        
        if txtEmail.text != "" && txtPassword.text != "" {
            btnLogin.isEnabled = true
            btnLogin.backgroundColor = UIColor(named: "darkBlue")
        }
        else{
            btnLogin.isEnabled = false
            btnLogin.backgroundColor =  UIColor(named: "lightGray")
        }
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let signUpVC = SignUpViewController(nibName: "SignUpView", bundle: nil)
        
        signUpVC.modalPresentationStyle = .fullScreen
        
        self.present(signUpVC, animated: false)
    }
    @IBAction func loginAction(_ sender: Any) {
        let tabBarVC = mainStoryboard.instantiateViewController(withIdentifier: "CustomTabBarVC")
        
        tabBarVC.modalPresentationStyle = .fullScreen
        
        present(tabBarVC, animated: true)
    }
}
