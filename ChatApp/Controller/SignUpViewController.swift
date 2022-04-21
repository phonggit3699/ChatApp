//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by PHONG on 07/04/2022.
//

import UIKit
import Alamofire

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

        btnSignUp.isEnabled = true
        
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

    @IBAction func btnSignUpAction(_ sender: Any) {
        signUp { isSignUp in
            print(isSignUp)
        }
    }
    
}

extension SignUpViewController{
    func signUp(handler: @escaping (Bool)->Void) {
        
        let newUser: Parameters = [
            "name": "Phong369",
            "password": "123456",
            "createdAt": "today"
        
        ]
        AF.request(userBaseURL, method: .post, parameters: newUser).responseDecodable(of: UserModel.self) { (response) in
            
            if let error = response.error {
                print(error)
            }
            
            if response.value != nil {
                handler(true)
            }
            else{
                handler(false)
            }
        }
    }
}
