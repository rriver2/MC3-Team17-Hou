//
//  EventCell.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/17.
//

import UIKit

class EventCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    
    func configure(with viewModel: Event) {
        if let data = viewModel.posterData {
            posterImage.image = UIImage(data: data)
        } else if let url = viewModel.posterURL {
            posterImage.image = UIImage(named: "tempPoster")
            posterImage.alpha = 0.4
            // fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.posterData = data
                DispatchQueue.main.async {
                    self?.posterImage.alpha = 1
                    self?.posterImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
