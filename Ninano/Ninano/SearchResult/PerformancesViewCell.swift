//
//  PerformancesViewCell.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/16.
//

import UIKit

class PerformancesViewCell: UICollectionViewCell {
    
    @IBOutlet var performanceImage: UIImageView!
    
    var imageName: String = "" {
        didSet {
            self.performanceImage.image = UIImage(named: imageName)
        }
    }
    
}
