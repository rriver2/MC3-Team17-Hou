//
//  InterestListViewController.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/14.
//

import UIKit

final class InterestListViewController: UIViewController {

    let sectionInsets = UIEdgeInsets(top: 15, left: 25, bottom: 15, right: 15)
    
    @IBOutlet weak var interestCollectionView: UICollectionView!
    private var articles: APIResponse?
    private var eventList = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopStories()
        
//        self.interestCollectionView.delegate = self
//        self.interestCollectionView.dataSource = self
    }
}

extension InterestListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoticeGridCollectionViewCell", for: indexPath) as? NoticeGridCollectionViewCell else { return UICollectionViewCell.init() }
        
        cell.gridImages.image = UIImage(data: eventList[indexPath.row].posterData ?? Data())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let itemsPerRow: CGFloat = 2
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 4
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width: CGFloat = collectionView.frame.width / 2 - 2
//        let height: CGFloat = collectionView.frame.height - 2
//
//        return CGSize(width: width, height: height)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 2.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 2.0
//    }
    
    func fetchTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                // MARK: viewModels를 가져오는데 시간이 걸리므로 가져온 후 CategoryCell에서 eventCollectionView를 reload 함.
                self?.eventList = articles.culturalEventInfo.row.compactMap({
                    Event(
                        title: String($0.title),
                        posterURL: URL(string: $0.mainImg ?? ""),
                        place: String($0.place),
                        area: String($0.guname),
                        period: String($0.date),
                        URL: String($0.orgLink ?? ""),
                        actor: String($0.player),
                        info: String($0.program),
                        price: String($0.useFee)
                    )
                })
                
                self?.eventList.forEach({ event in
                    event.fetchImage(url: event.posterURL) { success in
                        if success {
                            DispatchQueue.main.async {
                                self?.interestCollectionView.reloadData()
                            }
                        }
                    }
                })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
