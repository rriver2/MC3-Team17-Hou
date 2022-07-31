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
    private var interestViewModel = LikeDataModel()
    var tempLike: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterData()
        fetchTopStories()
    }
    
}

extension InterestListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempLike.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoticeGridCollectionViewCell", for: indexPath) as? NoticeGridCollectionViewCell else { return UICollectionViewCell.init() }
        
        cell.gridImages.image = UIImage(data: tempLike[indexPath.row].posterData ?? Data())
        cell.gridImages.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let screen = UIScreen.main.bounds.width
        let inset = (25 / 390) * screen
        let spacing = (14 / 390) * screen
        
        let width = (screen - (inset * 2) - spacing) / 2
        
        let height = (10 / 7) * width
        // 65
        
        flow.minimumLineSpacing = spacing
        flow.sectionInset.left = inset
        
        return CGSize(width: width, height: height)
    }
    
    func fetchTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                // MARK: viewModels를 가져오는데 시간이 걸리므로 가져온 후 CategoryCell에서 eventCollectionView를 reload 함.
                self?.eventList = articles.culturalEventInfo.row.compactMap({
                    Event(
                        title: String($0.title),
                        posterURL: URL(string: ($0.mainImg ?? "") + "p"),
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
                        DispatchQueue.main.async {
                            self?.interestCollectionView.reloadData()
                        }
                    }
                })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func filterData() {
        for like in interestViewModel.likeItems {
            let tempData = eventList.filter { $0.URL == like.url }
            tempLike += tempData
        }
    }
}
