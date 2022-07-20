//
//  SearchResultViewController.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/15.
//

import UIKit

final class SearchResultViewController: UIViewController {
    
    @IBOutlet var performanceCollectionView: UICollectionView!
    private var isRingButtonSelected = false
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
        super.viewDidLoad()
        
        // collectionView에 대한 설정
        performanceCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        performanceCollectionView.dataSource = self
        performanceCollectionView.delegate = self
    }
    
    @objc func presentModalController() {
        let controller = CalenderSearchResultViewController()
        present(controller, animated: true, completion: nil)
    }
    
    private func clickedLocalButton(local: LocationType) {
        selectedLocal = local
    }
    
    private func clickedFilterButton(_ sender: UIButton, _ filter: Filter) {
        let button = sender
        if filters.contains(filter) {
            if let index = filters.firstIndex(of: filter) {
                filters.remove(at: index)
            }
            button.configuration?.baseBackgroundColor = .systemGray5
            button.configuration?.cornerStyle = .capsule
        } else {
            filters.append(filter)
            button.configuration?.baseBackgroundColor = UIColor(hex: "D5DCF8")
            button.configuration?.cornerStyle = .capsule
        }
    }
    
    @IBAction func categoryFilterButton(_ sender: UIButton) {
        clickedFilterButton(sender, Filter.category)
    }
    
    @IBAction func localFilterButton(_ sender: UIButton) {
        clickedFilterButton(sender, Filter.local)
        let actionSheet = UIAlertController(title: "지역 선택", message: "공연 정보를 나타낼 지역을 설정해주세요.", preferredStyle: .actionSheet)
        let locals: [LocationType] = [.gangnam, .gangbook, .gurogu, .gwanakgu, .gwangjingu, .dobonggu, .nowongu]
        for local in locals {
            let location = local.rawValue
            actionSheet.addAction(UIAlertAction(title: location, style: .default, handler: { _ in
                sender.setTitle(location, for: .normal)
                sender.titleLabel?.font = .systemFont(ofSize: 13)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func notificationSettingsButton(_ sender: UIButton) {
        // TODO: 키워드 값 넣는 로직
        if isRingButtonSelected {
            sender.configuration?.baseForegroundColor = .systemGray
            isRingButtonSelected = false
        } else {
            sender.configuration?.baseForegroundColor = .red
            isRingButtonSelected = true
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
