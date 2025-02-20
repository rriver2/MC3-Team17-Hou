//
//  SearchResultViewController.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/15.
//

import UIKit

final class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var eventFilterButton: EventFilterButton!
    @IBOutlet private var performanceCollectionView: UICollectionView!
    @IBOutlet private weak var keywordNotification: UIButton!
    @IBOutlet private weak var keywordAddedNotification: UIStackView!
    @IBOutlet private weak var eventCollectionView: UICollectionView!
    private var isNotificationButtonSelected = false
    
    var tempEventList: [TempEvent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keywordAddedNotification.isHidden = true
        // collectionView에 대한 설정
        performanceCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        performanceCollectionView.dataSource = self
        performanceCollectionView.delegate = self
        eventFilterButton.datedeliveryDelegate = self
        
        let uiImage = UIImage(systemName: "chevron.left")
        let undo = UIBarButtonItem(image: uiImage, style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.leftBarButtonItem = undo
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 320, height: 0))
        searchBar.placeholder = "Search User"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        keywordNotification.layer.cornerRadius = 15
    }
    
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func keywordNotificationButton(_ sender: UIButton) {
    }
    
    @IBAction private func notificationSettingsButton(_ sender: UIButton) {
        // TODO: 키워드 값 넣는 로직
        if isNotificationButtonSelected == false {
            keywordAddedNotification.isHidden = false
            keywordAddedNotification.layer.cornerRadius = 15
            sender.isHidden = true
            
            isNotificationButtonSelected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UIView.animate(withDuration: 1) {
                    self.keywordAddedNotification.isHidden = true
                }
            }
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
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
        return self.tempEventList.count
    }
    /// 해당 cell에 무슨 view들을 표시할 지를 결정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = String(describing: PerformancesViewCell.self)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PerformancesViewCell {
            let tempEventData = self.tempEventList[indexPath.item]
            cell.updateEventCell(imageName: tempEventData.eventPosterName, title: tempEventData.eventName, date: tempEventData.eventDate, place: tempEventData.eventPlace)
            
            cell.contentView.layer.cornerRadius = 8
            return cell
        }
        
        return PerformancesViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let eventDetailView = UIStoryboard(name: "EventDetail", bundle: .main).instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController else { return }
        self.navigationController?.pushViewController(eventDetailView, animated: true)
    }
}

protocol DateDelivable: AnyObject {
    func addDate(date: Date)
}

protocol FilterButtonClickable: AnyObject {
    func openLocalActionSheet(actionSheet: UIAlertController)
    func openCaledarSearchResultView()
}

extension SearchResultViewController: DateDelivable, FilterButtonClickable {
    
    func addDate(date: Date) {
        let koreanDate = date.convertDateToKoreanDate(.koreanDate)
        let button: UIButton = eventFilterButton.dateFilterButton
        button.setTitle(koreanDate, for: .normal)
        button.configuration?.baseBackgroundColor = UIColor(hex: "D5DCF8")
        button.configuration?.cornerStyle = .capsule
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
