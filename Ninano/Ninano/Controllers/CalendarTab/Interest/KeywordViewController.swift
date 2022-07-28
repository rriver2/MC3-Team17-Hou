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
//    var imageList: [Data?]
    
    @IBOutlet weak var keywordTableView: UITableView!
    
    let img = ["22008595_p", "22007929_p", "22005098_p"]
    let keywordDate = ["3시간 전", "5일 전", "7월 31일 (일요일)"]
    let keywordTitle = ["깃발과 백설", "흑깃", "별이 흐르는 시간"]
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
        
        cell.keywordImage.image = UIImage(data: eventList[indexPath.row].posterData ?? Data())
        cell.keywordImage.layer.cornerRadius = 15
        cell.keywordTitle.text = eventList[indexPath.row].title
        cell.keywordTitle.font = UIFont.boldSystemFont(ofSize: 17)
        cell.keywordAlarmTitle.text = alarmTitle
        cell.keywordDate.text = eventList[indexPath.row].period
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
                DispatchQueue.main.async {
                    self?.keywordTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
