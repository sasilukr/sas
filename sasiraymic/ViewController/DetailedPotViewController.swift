//
//  DetailedPotViewController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 1/9/18.
//  Copyright © 2018 com.sasiluk. All rights reserved.
//

import Foundation

class DetailedPotViewController : UIViewController  {
    
    let potImageView = UIImageView()
    
    var pot: Pot!

    
    public convenience init(pot: Pot) {
        self.init()
        self.pot = pot
    }
    
//    override init(nibName: String?, bundle: Bundle?) {
//        super.init(nibName: nibName, bundle: bundle)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
