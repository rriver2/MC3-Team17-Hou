//
//  CalendarCollectionViewCell.swift
//  Ninano
//
//  Created by Yoonjae on 2022/07/19.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var dot: UIImageView!
    
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hideDot()
    }
    
    func update(date: String) {
            dateLabel.text = date
    }
    
    func showDot() {
        dot.backgroundColor = UIColor(hex: "F00000")
        dot.layer.cornerRadius = dot.frame.size.width / 2
        dot.clipsToBounds = true
    }
    
    private func hideDot() {
        dot.backgroundColor = nil
    }
}
