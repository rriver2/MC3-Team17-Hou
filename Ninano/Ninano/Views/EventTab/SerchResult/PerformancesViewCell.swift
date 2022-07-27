//
//  PerformancesViewCell.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/16.
//

import UIKit

final class PerformancesViewCell: UICollectionViewCell {
    
    @IBOutlet var performanceImage: UIImageView!
    
    var imageName: String = "" {
        didSet {
            performanceImage.layer.cornerRadius = 10
            performanceImage.contentMode = .scaleAspectFill
            
            let screen = UIScreen.main.bounds.width
            let inset = (25 / 390) * screen
            let spacing = (14 / 390) * screen
            
            let width = (screen - (inset * 2) - spacing) / 2
            let height = ( 4 / 3 ) * width
    
            let cropRect = CGRect(x: 0, y: 0, width: width, height: height)
            
            self.performanceImage.image = StaticFunc.cropImage(image: UIImage(named: imageName) ?? UIImage(), rect: cropRect)
            
        }
    }
//    private var isHeartedSelected = false
//    @IBAction func clickedHeart(_ sender: UIButton) {
//        if isHeartedSelected {
//            let config = UIImage.SymbolConfiguration(paletteColors: [.systemGray5, .systemGray, .darkGray])
//            let image = UIImage(systemName: "heart.circle.fill", withConfiguration: config)
//            sender.setImage(image, for: .normal)
//            isHeartedSelected = false
//        } else {
//            let config = UIImage.SymbolConfiguration(paletteColors: [.red, .systemGray, .darkGray])
//            let image = UIImage(systemName: "heart.circle.fill", withConfiguration: config)
//            sender.setImage(image, for: .normal)
//            isHeartedSelected = true
//        }
//    }
    
}
