//
//  SearchResultViewController.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/15.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet var performanceCollectionView: UICollectionView!
    
    fileprivate let systemImagesTemp = ["performanceImage1", "performanceImage2", "performanceImage1", "performanceImage2", "performanceImage1", "performanceImage2", "performanceImage1", "performanceImage2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // collectionView에 대한 설정
        performanceCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        performanceCollectionView.dataSource = self
        performanceCollectionView.delegate = self
    }
    
    private enum Filter {
        case local
        case category
        case date
    }
    
    private var filters: [Filter] = []
    
    @IBAction func keyWordAlertButton(_ sender: UIButton) {
    }
    
    @IBAction func localFilterButton(_ sender: UIButton) {
        clickedFilterButton(sender, Filter.local)
        let actionSheet = UIAlertController(title: "지역 선택", message: "공연 정보를 나타낼 지역을 설정해주세요.", preferredStyle: .actionSheet)
        let locals = ["강남", "강북", "구로구", "관악구", "광진구", "도봉구", "노원구"]
        for local in locals {
            actionSheet.addAction(UIAlertAction(title: local, style: .default, handler: { [self] _ in
                self.clickedLocalButton(local: local)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private var selectedLocal: String? {
        didSet {
            // TODO: 밑에 공연 filtering
            print("local inited: \(selectedLocal ?? "")")
        }
    }
    
    private func clickedLocalButton(local: String) {
        selectedLocal = local
    }
    
    @IBAction func categoryFilterButton(_ sender: UIButton) {
        clickedFilterButton(sender, Filter.category)
    }
    
    var datePicker: UIDatePicker!
    @IBAction func dateFilterButton(_ sender: UIButton) {
        clickedFilterButton(sender, Filter.date)
        
        datePicker = UIDatePicker()
        
        let actionSheet = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
                // TODO: Done 클릭 시 할 action 추가
            }))

        actionSheet.view.addSubview(datePicker)
        datePicker.preferredDatePickerStyle = .inline
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: actionSheet.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 400)
        actionSheet.view.addConstraint(height)
        // TODO: 달력 중간 정렬
        self.present(actionSheet, animated: true, completion: nil)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// 데이터 소스 설정 : 데이터와 관련된 것들
extension SearchResultViewController: UICollectionViewDataSource {
    // 각 섹션에 들어가는 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.systemImagesTemp.count
    }
    
    // 각 콜렉션 뷰의 셀에 대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = String(describing: PerformancesViewCell.self)
        
        // cell의 인스턴스
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PerformancesViewCell {
            cell.imageName = self.systemImagesTemp[indexPath.item]
            cell.contentView.layer.cornerRadius = 8
            
            return cell
        }
        
        return PerformancesViewCell()
    }
    
}

// 콜렉션 뷰 : 액션과 관련된 것들
extension SearchResultViewController: UICollectionViewDelegate {
    
}
//
//extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
//    // 위 아래 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    // 옆 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    // cell 사이즈( 옆 라인을 고려하여 설정 )
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = collectionView.frame.width / 3 - 1 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
//
//        let size = CGSize(width: width, height: width)
//        return size
//    }
//}

//extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let myBoundSize: CGFloat = UIScreen.main.bounds.size.width
//        let cellSize: CGFloat = myBoundSize / 9
//        return CGSize(width: cellSize, height: 40)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 0, height: 5)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.top
//    }
//
//}
//Footer

