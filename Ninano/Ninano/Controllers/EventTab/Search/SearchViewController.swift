//
//  SearchViewController.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/16.
//

import UIKit
import CloudKit

class SearchViewController: UIViewController {
//    private var titleFont = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title2, weight: .bold)]
    private var categoryConfig = UIButton.Configuration.plain()
    private var categoryFont = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)

    private enum Category: String, CaseIterable {
        case recommended = "니나노의 추천 공연"
        case thisMonth = "이번 달 예정 공연"
        case free = "무료 공연"
        case liked = "내가 구독한 공연"
        
        static let allValues = [recommended, thisMonth, free, liked]
    }
    
    private var articles: APIResponse?
    private var eventList = [Event]()
    
    private let numberOfCells: Int = 8
    
    @IBOutlet private var categoryTableView: UITableView!
    
    @IBAction func didTouchSearchButton(_ sender: UIButton) {
        guard let searchResultView = UIStoryboard(name: "SearchResult", bundle: .main).instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultViewController else { return }
        searchResultView.eventList = eventList
        // TODO: 내가 좋아할 만한 공연 화면으로 넘어가면 detailCatagory, 검색 화면으로 넘어가면 .searchResult(navigationTitle: String)
        searchResultView.viewCatagory = .searchResult
        self.navigationController?.pushViewController(searchResultView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.navigationBar.largeTitleTextAttributes = titleFont
        configNavigationTitle()
        fetchTopStories()
    }
    
    private func configNavigationTitle() {
        let viewWidth = self.view.bounds.width - 100
        print(viewWidth)
        let searchViewTitle = UILabel(frame: CGRect(x: 25, y: 0, width: viewWidth, height: 20))
        searchViewTitle.textAlignment = .left
        searchViewTitle.font = UIFont.preferredFont(forTextStyle: .title2, weight: .bold)
        searchViewTitle.text = "공연 추천"
        self.navigationItem.titleView = searchViewTitle
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
        cell.categoryName.titleLabel?.adjustsFontForContentSizeCategory = true
        cell.categoryChevron.titleLabel?.font = categoryFont
        
        switch indexPath.row {
        case 0:
            var recommendedEvent: [Event] = []
            var recommendedEventSet: Set<Event> = []
//            let shuffledEvent: [Event] = eventList.shuffled()
            
            while recommendedEventSet.count < numberOfCells {
                if let randomEvent = eventList.randomElement() {
                    recommendedEventSet.insert(randomEvent)
                    if recommendedEventSet.count > 0 {
                        recommendedEvent.append(randomEvent)
                    }
                }
            }
            
//            for _ in 0..<numberOfCells {
//                recommendedEvent.append(shuffledEvent[index])
//                if let randomEvent = eventList.randomElement() {
//                    recommendedEvent.append(randomEvent)
//                }
//            }
            cell.eventList = recommendedEvent
            
        case 1:
            cell.eventList = eventList
        case 2:
            cell.eventList = eventList
        case 3:
            cell.eventList = eventList
        default:
            return UITableViewCell()
        }
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
