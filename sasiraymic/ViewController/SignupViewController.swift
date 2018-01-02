//
//  SignupViewController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/30/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    var usernameTextField = UITextField()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var signupButton = UIButton()
    var cancelButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.placeholder = R.string.localizable.signupUsername()
        usernameTextField.backgroundColor = Style.Color.Primary.ui
        usernameTextField.layer.cornerRadius = Style.Spacing.X2
        
        emailTextField.placeholder = R.string.localizable.loginEmail()
        emailTextField.backgroundColor = Style.Color.Primary.ui
        emailTextField.layer.cornerRadius = Style.Spacing.X2
        
        passwordTextField.placeholder = R.string.localizable.loginPassword()
        passwordTextField.backgroundColor = Style.Color.Primary.ui
        passwordTextField.layer.cornerRadius = Style.Spacing.X2
        
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.setTitle(R.string.localizable.buttonSignup(), for: .normal)
        
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitle(R.string.localizable.buttonCancel(), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        
        self.view.addSubview(usernameTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signupButton)
        self.view.addSubview(cancelButton)

        self.view.backgroundColor = .white
        
        usernameTextField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.view.snp.top).offset(Style.Spacing.X8)
        }
        
        emailTextField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.usernameTextField.snp.bottom).offset(Style.Spacing.X2)
        }
        
        passwordTextField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.emailTextField.snp.bottom).offset(Style.Spacing.X2)
        }
        
        
        signupButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width/2)
            m.height.equalTo(Style.Spacing.X4)
            m.top.equalTo(self.passwordTextField.snp.bottom).offset(Style.Spacing.X6)
            m.left.equalTo(self.view.snp.left)
        }
        
        cancelButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width/2)
            m.height.equalTo(Style.Spacing.X4)
            m.top.equalTo(self.signupButton.snp.top)
            m.left.equalTo(self.signupButton.snp.right)
        }
        
    }
    
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
}


