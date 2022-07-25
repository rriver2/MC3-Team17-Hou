//
//  SearchResultViewController.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/15.
//

import UIKit

protocol DateDelivable: AnyObject {
    func addDate(date: String)
}

final class SearchResultViewController: UIViewController, DateDelivable {
    
    @IBOutlet private var performanceCollectionView: UICollectionView!
    @IBOutlet private weak var keywordNotification: UIButton!
    @IBOutlet private weak var dateFilterButton: UIButton!
    @IBOutlet private weak var keywordAddedNotification: UIStackView!
    @IBOutlet private weak var eventCollectionView: UICollectionView!
    private var isNotificationButtonSelected = false
    private var filters: [Filter] = []
    private var selectedLocal: LocationType? {
        didSet {
            // TODO: 밑에 공연 filtering
            print("local inited: \(selectedLocal?.rawValue ?? "")")
        }
    }
    fileprivate let systemImagesTemp = ["performanceImage1", "performanceImage2", "performanceImage1", "performanceImage2", "performanceImage1", "performanceImage2", "performanceImage1", "performanceImage2", "performanceImage1", "performanceImage2", "performanceImage1", "performanceImage2", "performanceImage1", "performanceImage2", "performanceImage1", "performanceImage2"]
    
    private enum Filter {
        case local
        case category
        case date
    }
    
    private enum LocationType: String {
        case gangnam = "강남"
        case gangbook = "강북"
        case gurogu = "구로구"
        case gwanakgu = "관악구"
        case gwangjingu = "광진구"
        case dobonggu = "도봉구"
        case nowongu = "노원구"
    }
    
    override func viewDidLoad() {
        keywordAddedNotification.isHidden = true
        // collectionView에 대한 설정
        performanceCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        performanceCollectionView.dataSource = self
        performanceCollectionView.delegate = self
        
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
    
    @objc private func presentModalController() {
        let controller = CalenderSearchResultViewController()
        present(controller, animated: true, completion: nil)
    }
    
    private func clickedFilterButtonColorChange(_ sender: UIButton) {
        let button = sender
            button.configuration?.baseBackgroundColor = UIColor(hex: "D5DCF8")
            button.configuration?.cornerStyle = .capsule
    }
    
    func addDate(date: String) {
        dateFilterButton.setTitle(date, for: .normal)
        clickedFilterButtonColorChange(dateFilterButton)
    }
    
    @IBAction private func keywordNotificationButton(_ sender: UIButton) {
    }
    
    @IBAction private func localFilterButton(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "지역 선택", message: "공연 정보를 나타낼 지역을 설정해주세요.", preferredStyle: .actionSheet)
        let locals: [LocationType] = [.gangnam, .gangbook, .gurogu, .gwanakgu, .gwangjingu, .dobonggu, .nowongu]
        for local in locals {
            let location = local.rawValue
            actionSheet.addAction(UIAlertAction(title: location, style: .default, handler: { [self] _ in
                clickedFilterButtonColorChange(sender)
                sender.titleLabel?.text = location
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction private func dateFilterButton(_ sender: UIButton) {
        guard let calenderSearchResult = self.storyboard?.instantiateViewController(withIdentifier: "CalenderSearchResultViewController") as? CalenderSearchResultViewController else { return }
                self.present(calenderSearchResult, animated: true, completion: nil)
        calenderSearchResult.datedeliveryDelegate = self
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let numberOfCells: CGFloat = 3
        let width = collectionView.frame.size.width - (flowLayout.minimumInteritemSpacing * (numberOfCells-1))
        return CGSize(width: width/(numberOfCells), height: width/(numberOfCells))
    }
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.systemImagesTemp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = String(describing: PerformancesViewCell.self)
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PerformancesViewCell {
            cell.imageName = self.systemImagesTemp[indexPath.item]
            cell.contentView.layer.cornerRadius = 8
            return cell
        }
        
        return PerformancesViewCell()
    }
}
