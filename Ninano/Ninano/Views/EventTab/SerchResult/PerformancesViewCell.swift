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
            
            let image = UIImage(named: imageName)
            
            let screen = UIScreen.main.bounds.width
            let inset = (25 / 390) * screen
            let spacing = (14 / 390) * screen
            
            let cropWidth = (screen - (inset * 2) - spacing) / 2
            let cropHeight = ( 4 / 3 ) * cropWidth
            
            let imageWidth = image?.size.width ?? 0
            let imageHeight = image?.size.height ?? 0
            
            if imageWidth == 0 { print("imageWidth")}
            if imageHeight == 0 { print("imageHeight")}
            
            let imageX = (imageWidth - cropWidth) / 2
            let imageY = (imageHeight - cropHeight) / 2
    
            let cropRect = CGRect(x: imageX, y: imageY, width: cropWidth, height: cropHeight)
            
            self.performanceImage.image = StaticFunc.cropImage(image: image ?? UIImage(), rect: cropRect)
            
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
