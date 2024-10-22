//
//  PerformancesViewCell.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/16.
//

import UIKit

final class PerformancesViewCell: UICollectionViewCell {
    
    @IBOutlet private var eventImageView: UIImageView!
    @IBOutlet private weak var eventTitleLabel: UILabel!
    @IBOutlet private weak var eventDateLabel: UILabel!
    @IBOutlet private weak var eventPlaceLabel: UILabel!
    
    func updateEventCell(imageName: String, title: String, date: String, place: String) {
        addImage(imageName: imageName)
        self.eventTitleLabel.text = title
        self.eventDateLabel.text = date
        self.eventPlaceLabel.text = place
    }
    
    private func addImage(imageName: String) {
        eventImageView.layer.cornerRadius = 10
        eventImageView.contentMode = .scaleAspectFill
        
        let image = UIImage(named: imageName) ?? UIImage()
        let cropRect = cropImageSetting(UIImage: image)
        
        self.eventImageView.image = image.cropImage(rect: cropRect)
    }
    
    private func cropImageSetting(UIImage: UIImage) -> CGRect {
        
        let screen = UIScreen.main.bounds.width
        let inset = (25 / 390) * screen
        let spacing = (14 / 390) * screen
        
        let cropWidth = (screen - (inset * 2) - spacing) / 2
        let cropHeight = ( 4 / 3 ) * cropWidth
        
        let imageWidth = UIImage.size.width
        let imageHeight = UIImage.size.height
        
        if imageWidth == 0 { print("imageWidth")}
        if imageHeight == 0 { print("imageHeight")}
        
        let imageX = (imageWidth - cropWidth) / 2
        let imageY = (imageHeight - cropHeight) / 2
        
        return CGRect(x: imageX, y: imageY, width: cropWidth, height: cropHeight)
    }
    
    // MARK: 후에 다시 사용할 수 있어서 남겨두었습니다.
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
