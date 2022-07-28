//
//  SearchViewController.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/16.
//

import UIKit

class SearchViewController: UIViewController {
    private var categoryConfig = UIButton.Configuration.plain()
    private var categoryFont = UIFont.boldSystemFont(ofSize: 15)

    private enum Category: String, CaseIterable {
        case recommended = "니나노의 추천 공연"
        case thisMonth = "이번 달 예정 공연"
        case free = "무료 공연"
        case liked = "내가 구독한 공연"
        
        static let allValues = [recommended, thisMonth, free, liked]
    }
    
    private var articles: APIResponse?
    private var eventList = [Event]()
    
    @IBOutlet private var categoryTableView: UITableView!
    
    @IBAction func didTouchSearchButton(_ sender: UIButton) {
        guard let calenderModal = UIStoryboard(name: "SearchResult", bundle: .main).instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultViewController else { return }
        // TODO: [Event] 타입의 eventData 전달해주세요 ! 우선 가데이터로 넣어놨습니다 !
         calenderModal.tempEventList = [
        TempEvent(eventName: "반향1", eventPosterName: "22008615_p", eventPlace: "경기아트센터 대극장", eventPeriod: "2022.7.15~2022.7.20", eventDate: "2022.03.14", eventTime: "20:00", isLiked: true, isReserved: true),
        TempEvent(eventName: "반향2", eventPosterName: "22008595_p", eventPlace: "경기아트센터 대극장2", eventPeriod: "2022.7.15~2022.7.20", eventDate: "2022.03.21", eventTime: "20:00", isLiked: true, isReserved: true),
        TempEvent(eventName: "반향3", eventPosterName: "22006547_p", eventPlace: "경기아트센터 대극장3", eventPeriod: "2022.7.15~2022.7.20", eventDate: "2022.03.12", eventTime: "20:00", isLiked: true, isReserved: true),
        TempEvent(eventName: "반향4", eventPosterName: "22005605_p", eventPlace: "경기아트센터 대극장", eventPeriod: "2022.7.15~2022.7.20", eventDate: "2022.02.02", eventTime: "20:00", isLiked: true, isReserved: true)
    ]
        self.navigationController?.pushViewController(calenderModal, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopStories()
        // Do any additional setup after loading the view.
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryCell else {
            return UITableViewCell()
        }
        categoryConfig.title = Category.allValues[indexPath.row].rawValue
        cell.categoryName.configuration = categoryConfig
        cell.categoryName.titleLabel?.font = categoryFont
        cell.categoryChevron.titleLabel?.font = categoryFont
        cell.eventList = eventList
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
                    self?.categoryTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
