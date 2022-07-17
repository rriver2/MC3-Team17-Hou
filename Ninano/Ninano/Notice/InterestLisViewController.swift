//
//  InterestLisViewController.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/14.
//

import UIKit

class InterestLisViewController: UIViewController {

    @IBOutlet weak var interestCollectionView: UICollectionView!
    
    let gridImage = ["camera.macro.circle", "camera.macro.circle.fill", "sun.dust.fill", "cloud.moon.bolt", "hurricane", "wrench", "radio.fill"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension InterestLisViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoticeGridCollectionViewCell", for: indexPath) as! NoticeGridCollectionViewCell
        
        cell.gridImages.image = UIImage(systemName: gridImage[indexPath.row]) ?? UIImage()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 2 - 2.0
        let height: CGFloat = collectionView.frame.height / 4
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2.0
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
}
