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
    
    func updateEventCell(event: Event) {
        self.eventTitleLabel.text = event.title
        self.eventDateLabel.text = event.period?.dateFormatForUI()
        self.eventPlaceLabel.text = event.place
        if let data = event.posterData {
            let image = (UIImage(data: data) ?? UIImage(named: "tempPoster"))!
            self.eventImageView.image = resizeImage(image: image)
        } else {
            self.eventImageView.image = resizeImage(image: UIImage(named: "tempPoster")!)
        }
        configuration()
    }
    
    func resizeImage(image: UIImage) -> UIImage? {
        let screen = UIScreen.main.bounds.width
        let inset = (25 / 390) * screen
        let spacing = (14 / 390) * screen
        
        let newWidth = (screen - (inset * 2) - spacing) / 2
        
        let newHeight = newWidth * ( 4 / 3 )
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        newImage = newImage?.withRoundedCorners(radius: 10)
        
        return newImage
    }
    
    private func configuration() {
        eventTitleLabel.font = UIFont.preferredFont(forTextStyle: .caption2, weight: .bold)
        eventDateLabel.font = UIFont.preferredFont(forTextStyle: .caption2, weight: .regular)
        eventPlaceLabel.font = UIFont.preferredFont(forTextStyle: .caption2, weight: .regular)
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
