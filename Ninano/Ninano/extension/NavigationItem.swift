//
//  NavigationItem.swift
//  Ninano
//
//  Created by Yoonjae on 2022/07/21.
//

import UIKit

class LargeNavigation: UINavigationController {
    @IBInspectable var navigationLargeTitleBarColor: UIColor {
        set {
            self.view.backgroundColor = newValue
        }
        get {
            return self.view.backgroundColor ?? UIColor.black
        }
    }
}
