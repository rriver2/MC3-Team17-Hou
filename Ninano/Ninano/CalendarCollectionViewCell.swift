//
//  CalendarCollectionViewCell.swift
//  Ninano
//
//  Created by Yoonjae on 2022/07/19.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func update(date: String) {
            dateLabel.text = date
        }
    
}
