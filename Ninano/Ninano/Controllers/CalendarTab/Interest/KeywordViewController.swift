//
//  KeywordViewController.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/14.
//

import UIKit

class KeywordViewController: UIViewController {
    
    private var articles: APIResponse?
    private var eventList = [Event]()
    var keywordViewModel = KeywordDataModel()

    @IBOutlet weak var keywordTableView: UITableView!

    let alarmTitle = "레버 관심설정의 새로운 공연일정이 추가되었습니다."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopStories()
        layout()
    }
}

extension KeywordViewController {
    
    func layout() {
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
        keywordTableView.rowHeight = 90
        keywordTableView.separatorStyle = .none
        keywordTableView.showsVerticalScrollIndicator = false
    }
}

extension KeywordViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noticeKeyword", for: indexPath) as? KeywordTableViewCell else { return UITableViewCell.init() }
        
        if keywordViewModel.keywordItems.isEmpty {
            
            
        }
            
        
        
        
        guard !keywordViewModel.keywordItems.isEmpty else {
            return UITableViewCell.init() }
        
//        if keywordViewModel.keywordItems.isEmpty {
//            replaceLabel.text = "없음"
//        } else {
//            for keyword in  keywordViewModel.keywordItems {
//
//            }
//        }
//        for keyword in keywordViewModel.keywordItems {
//            cell.keywordImage.image = UIImage(data: eventList.filter({ event in
//                event.info
//            })[indexPath.row].posterData ?? Data())
//            
//        }
        cell.keywordTitle.text = eventList[indexPath.row].title
        cell.keywordDate.text = eventList[indexPath.row].period
        cell.keywordImage.layer.cornerRadius = 15
        cell.keywordTitle.font = UIFont.boldSystemFont(ofSize: 17)
        cell.keywordAlarmTitle.text = alarmTitle
        cell.keywordBackgroundCell.layer.cornerRadius = 15
        
        return cell
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
                                self?.keywordTableView.reloadData()
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
