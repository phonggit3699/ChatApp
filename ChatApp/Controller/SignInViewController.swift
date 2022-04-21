//
//  SignInViewController.swift
//  ChatApp
//
//  Created by PHONG on 06/04/2022.
//

import UIKit
import SocketIO
import Alamofire


class SignInViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblTestSocket: UILabel!
    
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
        
        self.present(signUpVC, animated: true)
    }
    @IBAction func loginAction(_ sender: Any) {
        
        let tabBarVC = mainStoryboard.instantiateViewController(withIdentifier: "CustomTabBarVC")

        tabBarVC.modalPresentationStyle = .fullScreen

        login { isLogin in
            if isLogin == true {
                self.present(tabBarVC, animated: true)
            }
        }
     
    
    }
    @IBAction func btnForgotPasswordActon(_ sender: Any) {
        
        let resetPassVC = ResetPasswordViewController(nibName: "ResetPasswordView", bundle: nil)
        
        resetPassVC.modalPresentationStyle = .fullScreen
        
        self.present(resetPassVC, animated: false)
    }
}

extension SignInViewController {
    func login(handler: @escaping (Bool)->Void) {
      
        if let text = self.txtEmail.text, text != "" {
            let loginUrl = userBaseURL + "?name=\(text.trimmingCharacters(in: .whitespaces))"
            guard let loginUrl = loginUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                return
            }

            AF.request(loginUrl).validate().responseDecodable(of: [UserModel].self) { (response) in
                
                if let error = response.error {
                    print(error)
                }
                
                if let value = response.value  {
                    if value[0].name == text.trimmingCharacters(in: .whitespaces) {
                        handler(true)
                    }
                    else{
                        handler(false)
                    }
                }
                else{
                    handler(false)
                }
            }
        }
        else{
            handler(false)
        }
    }
}
