//
//  SignInViewController.swift
//  ChatApp
//
//  Created by PHONG on 06/04/2022.
//

import UIKit
import SocketIO


class SignInViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblTestSocket: UILabel!
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
//    let manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = 26
        btnLogin.isEnabled = true
 
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
    @IBAction func btnForgotPasswordActon(_ sender: Any) {
        
        let resetPassVC = ResetPasswordViewController(nibName: "ResetPasswordView", bundle: nil)
        
        resetPassVC.modalPresentationStyle = .fullScreen
        
        self.present(resetPassVC, animated: false)
    }
}

extension SignInViewController {
//    func setupSocket(){
//
//        let socket = manager.defaultSocket
//
//        socket.on(clientEvent: .connect) {data, ack in
//            print("socket connected")
//            socket.emit("socket message", "Hi Socket")
//        }
//
//        socket.on("phong message") { data, ack in
//            if let dataString: [String: String] = data[0] as? [String: String],  let test: String = dataString["msg"] {
//
//                print(test)
//            }
//
//        }
//        socket.connect()
//    }
}
