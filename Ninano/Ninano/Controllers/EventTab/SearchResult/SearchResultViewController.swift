//
//  SearchResultViewController.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/15.
//

import UIKit

final class SearchResultViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var eventFilterButton: EventFilterButton!
    @IBOutlet private var performanceCollectionView: UICollectionView!
    @IBOutlet private weak var keywordNotification: UIButton!
    @IBOutlet private weak var keywordAddedNotification: UIStackView!
    @IBOutlet private weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var keywordAlarmLabel: UILabel!
    @IBOutlet weak var keywordSettingButton: UIButton!
    @IBOutlet weak var alertEmptyEventLabel: UILabel!
    private var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 300, height: 0))
    private var keywordViewModel = KeywordDataModel()
    private var local: String? {
        didSet {
            reloadCollection()
        }
    }
    private var date: Date? {
        didSet {
            reloadCollection()
        }
    }
    private var searchKeyword: String? {
        didSet {
            reloadCollection()
        }
    }
    
    var eventList: [Event] = []
    var copyEventList: [Event] = []
    var viewCatagory: SearchDetailCatagory?
    
    enum SearchDetailCatagory {
        case searchCatagory(navigationTitle: String)
        case searchResult
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // config
        navigationConfig()
        determineViewCatagory()
        keywordNotification.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)
        keywordAlarmLabel.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)
        keywordSettingButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)
        keywordAddedNotification.isHidden = true
        keywordAddedNotification.isHidden = true
        keywordNotification.isHidden = true
        keywordAddedNotification.layer.cornerRadius = 15
        keywordNotification.layer.cornerRadius = 15
        // delegate
        searchBar.delegate = self
        performanceCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        performanceCollectionView.dataSource = self
        performanceCollectionView.delegate = self
        eventFilterButton.datedeliveryDelegate = self
        alertEmptyEventLabel.isHidden = true
        // data
        copyEventList = eventList
            // eventList에서 지역구만 빼내기
        var eventListArea: Array = Array(Set(eventList.compactMap { $0.area })).sorted()
        eventListArea.append("전체")
        eventFilterButton.local = eventListArea
    }
    
    private func reloadCollection() {
        var filterEvent: [Event] = eventList
        // date 정제
        if let compareDate = self.date {
            filterEvent = filterEvent.filter {
                 if let period = $0.period {
                     let dateList = period.periodToDateList()
                     
                     if dateList.count == 1 {
                         if dateList[0].isDateToday(fromDate: compareDate) {
                             return true
                         } else {
                             return false
                         }
                     } else {
                         let range = dateList[0]...dateList[1]
                         if range.contains(compareDate) {
                             return true
                         } else {
                             return false
                         }
                     }
                 }
                 return false
             }
        }
        // local 정제
        if let compareLocal = self.local {
            if compareLocal != "전체" {
                filterEvent = filterEvent.filter { $0.area == compareLocal }
            }
        }
        // searchWord 정제
        if let searchKeyword = self.searchKeyword, searchKeyword != "" {
            filterEvent = filterEvent.filter {
                if $0.title.contains(searchKeyword) {
                    return true
                } else if let place = $0.place, place.contains(searchKeyword) {
                    return true
                } else if let area = $0.area, area.contains(searchKeyword) {
                    return true
                } else if let period = $0.period, period.contains(searchKeyword) {
                    return true
                } else if let actor = $0.actor, actor.contains(searchKeyword) {
                    return true
                } else if let info = $0.info, info.contains(searchKeyword) {
                    return true
                } else if let price = $0.price, price.contains(searchKeyword) {
                    return true
                }
                return false
            }
        }
        // collectionView update
        copyEventList = filterEvent
        performanceCollectionView.reloadData()
        
        if copyEventList.isEmpty {
            alertEmptyEventLabel.isHidden = false
        } else {
            alertEmptyEventLabel.isHidden = true
        }
    }
    
    private func navigationConfig() {
        var backImage = UIImage(named: "backIcon")
        backImage = backImage?.resizeImage(newWidth: 35)
        
        let backButton = UIButton()
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        let backBtn = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    private func determineViewCatagory() {
        switch viewCatagory {
            case .searchCatagory(let navigationTitle):
                let searchCatagoryTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
                searchCatagoryTitle.textAlignment = .center
                searchCatagoryTitle.font = UIFont.preferredFont(forTextStyle: .title3, weight: .bold)
                searchCatagoryTitle.text = navigationTitle
                self.navigationItem.titleView = searchCatagoryTitle
            case .searchResult:
                self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width - 90, height: 0))
                searchBar.placeholder = "공연을 검색하세요"
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
            case .none:
                print("viewCatagory error")
        }
    }
    
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard(searchBar)
        
        let isKeywordInCoreData = keywordViewModel.keywordItems.contains { keywordList in
            return keywordList.keywordSubs == searchBar.text
        }
        if isKeywordInCoreData {
            keywordNotification.isHidden = true
        } else {
            keywordNotification.isHidden = false
        }
    }
    
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchKeyword = searchBar.text
    }
    
    private func dismissKeyboard(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func keywordNotificationButton(_ sender: UIButton) {
        if let keyWord = searchBar.text {
            keywordViewModel.addKeywordItems(keyword: keyWord)
        }
        keywordAddedNotification.isHidden = false
        keywordNotification.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 1) {
                self.keywordAddedNotification.isHidden = true
            }
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    // collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let screen = UIScreen.main.bounds.width
        let inset = (25 / 390) * screen
        let spacing = (14 / 390) * screen
        
        let width = (screen - (inset * 2) - spacing) / 2
        
        let height = (4 / 3) * width + 65
        
        flow.minimumLineSpacing = spacing
        flow.sectionInset.left = inset
        
        return CGSize(width: width, height: height)
    }
    
}

// 컬렉션 뷰의 셀은 총 몇 개? (UICollectionViewDataSource)
// 컬렉션 뷰를 어떻게 보여줄 것인가 ? (UICollectionViewDelegate)
extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // UICollectionViewDataSource와 관련된 함수 2개
    /// 콜렉션 뷰에 총 몇 개의 셀(cell)을 표시할 것인지를 구현
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.copyEventList.count
    }
    /// 해당 cell에 무슨 view들을 표시할 지를 결정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = String(describing: PerformancesViewCell.self)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PerformancesViewCell {
            let eventData = self.copyEventList[indexPath.item]
            cell.updateEventCell(event: eventData)
            cell.contentView.layer.cornerRadius = 8
            return cell
        }
        
        return PerformancesViewCell()
    }
    /// 셀을 선택했을 때 액션 추가 가능
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let eventDetailView = UIStoryboard(name: "EventDetail", bundle: .main).instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController else { return }
        eventDetailView.event = self.copyEventList[indexPath.item]
        self.navigationController?.pushViewController(eventDetailView, animated: true)
    }
}

protocol DateDelivable: AnyObject {
    func addDate(date: Date)
}

protocol EventButtonFilterable: AnyObject {
    func openLocalActionSheet(actionSheet: UIAlertController)
    func openCaledarSearchResultView()
    func filterCollctionCell(criteria: FilterCriteria)
}

enum FilterCriteria {
    case date(_ date: Date)
    case local(_ local: String)
}

extension SearchResultViewController: DateDelivable, EventButtonFilterable {
    
    func filterCollctionCell(criteria: FilterCriteria) {
        switch criteria {
            case .date(let compareDate):
                self.date = compareDate
            case .local(let local):
                self.local = local
        }
    }
    
    func addDate(date: Date) {
        let koreanDate = date.convertDateToOtherType(.koreanDate)
        let button: UIButton = eventFilterButton.dateFilterButton
        let attribute = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)]
        let attributedTitle = NSAttributedString(string: koreanDate, attributes: attribute)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = CustomColor.buttonLightRed
        
        filterCollctionCell(criteria: .date(date))
    }
    
    func openLocalActionSheet(actionSheet: UIAlertController) {
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func openCaledarSearchResultView() {
        guard let calenderModal = UIStoryboard(name: "CalenderModal", bundle: .main).instantiateViewController(withIdentifier: "CalenderModalViewController") as? CalenderModalViewController else { return }
        calenderModal.datedeliveryDelegate = self
        self.present(calenderModal, animated: true, completion: nil)
    }
}
