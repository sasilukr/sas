//
//  FirstViewController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/26/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var glazeTableView: UITableView!

    var glazeList = ["Butter White", "Lily Clear", "Honey White", "Stone Black"]
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loginAction),
                                               name: .onLogin,
                                               object: nil)
        glazeTableView = UITableView()
        glazeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "GlazeTableViewCell")
        glazeTableView.dataSource = self
        glazeTableView.delegate = self
        glazeTableView.backgroundColor = .black
        
        self.view.addSubview(glazeTableView)
        
        glazeTableView.snp.makeConstraints { m in
            m.edges.equalTo(self.view.snp.edges)
        }
        
    }

    func fetchPots() {
//        ApiClient.shared.getPots()
    }
    
    @objc func loginAction() {
        print("\(#function)")
//        self.fetchPots()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.glazeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "GlazeTableViewCell")
        cell.textLabel?.text = self.glazeList[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(PotsCollectionViewController(), animated: true)
    }
}

