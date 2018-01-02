//
//  FirstViewController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/26/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loginAction),
                                               name: .onLogin,
                                               object: nil)
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.fetchPots()
//    }

    func fetchPots() {
        ApiClient.shared.getPots()
    }
    
    @objc func loginAction() {
        self.fetchPots()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

