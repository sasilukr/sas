//
//  ProfileViewController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/26/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import UIKit
import AVFoundation

class ProfileViewController: UIViewController {
    
    var logoutButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(logoutButton)
        logoutButton.tintColor = .black
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.setTitle(R.string.localizable.buttonLogout(), for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        logoutButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.center.equalTo(self.view.snp.center)
        }
        
        
    }
    
    @objc func logoutAction() {
        NotificationCenter.default.post(name: .onLogout, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
