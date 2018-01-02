//
//  Constants.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/29/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//
import UIKit

struct Style {
    struct Spacing {
        static let X1 : CGFloat = 2.0
        static let X2 : CGFloat = 4.0
        static let X3 : CGFloat = 8.0
        static let X4 : CGFloat = 16.0
        static let X5 : CGFloat = 24.0
        static let X6 : CGFloat = 32.0
        static let X7 : CGFloat = 40.0
        static let X8 : CGFloat = 56.0
    }
    
    enum Color: UInt32 {
        
        case Primary = 0xFF648F29
        case Secondary = 0xFFA0C232
        case Tertiary = 0xFFC8DA37
        case Quatenary = 0xFFEAE639
        case fifth = 0xFF9FDAD1
        
        var ui: UIColor { return UIColor.fromHex(rawValue) }
        var cg: CGColor { return ui.cgColor }
    }
}

extension Notification.Name {
    static let onLogin = Notification.Name("on-log-in")
    static let onLogout = Notification.Name("on-log-out")
}


