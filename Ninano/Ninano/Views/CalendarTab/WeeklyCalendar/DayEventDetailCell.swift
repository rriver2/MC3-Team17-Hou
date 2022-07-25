//
//  DayEventDetailCell.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/19.
//

import UIKit

final class DayEventDetailCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventPlaceLabel: UILabel!
    @IBOutlet weak var eventPeriodLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var planned: UIImageView!
    @IBOutlet weak var liked: UIImageView!
}
