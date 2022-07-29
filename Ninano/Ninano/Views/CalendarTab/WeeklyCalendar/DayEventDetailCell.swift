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
    @IBOutlet weak var planned: UIImageView!
    @IBOutlet weak var liked: UIImageView!
    
    func configure(with viewModel: Event) {
        eventNameLabel.text = viewModel.title
        eventPlaceLabel.text = viewModel.place
        eventPeriodLabel.text = viewModel.period
        if let data = viewModel.posterData {
            posterImage.image = UIImage(data: data)
        } else if let url = viewModel.posterURL {
            // fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.posterData = data
                DispatchQueue.main.async {
                    self?.posterImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
