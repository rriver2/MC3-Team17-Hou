//
//  CategoryCell.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/17.
//

import UIKit

class CategoryCell: UITableViewCell {
    let eventPosters = ["banhyang", "guiTo", "heungboga", "kookakINgayo", "kyeok"]
    var eventPoster: UIImage?
    let eventPosterView: UIImageView = {
        let posterView = UIImageView()
        posterView.layer.cornerRadius = 10
        return posterView
    }()
           
    @IBOutlet weak var categoryName: UIButton!
    @IBOutlet weak var categoryChevron: UIButton!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
}

extension CategoryCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventPosters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as? EventCell else {
            return UICollectionViewCell()
        }
        eventPoster = UIImage(named: "\(eventPosters[indexPath.row]).png")
        cell.posterImage.image = eventPoster
        cell.posterImage = eventPosterView
        return cell
    }
}
