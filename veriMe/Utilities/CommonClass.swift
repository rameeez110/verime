//
//  CommonClass.swift
//  veriMe
//
//  Created by Rameez Hasan on 28/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class CommonClass: NSObject {
    
    static var sharedInstance = CommonClass()
    
    //Side Menu
    var leftDrawerTransition:DrawerTransition!
    
    func customizeUINavigationBar() {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.font: UIFont(name: "Comfortaa-Bold", size: 19)!
        ]

        UINavigationBar.appearance().titleTextAttributes = attrs
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Comfortaa-Bold", size: 16)!], for: .normal)
    }
    
    func customizeUITabBar() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Comfortaa-Bold", size: 12)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Comfortaa-Bold", size: 12)!], for: .selected)
    }
    
    func customizeUISearchBar() {
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont(name: "Comfortaa-Bold", size: 14)!
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont(name: "Comfortaa-Bold", size: 14)!
    }
}
