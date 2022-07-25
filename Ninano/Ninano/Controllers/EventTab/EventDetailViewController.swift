//
//  ViewController.swift
//  Ninano
//
//  Created by 임영후 on 2022/07/11.
//

import UIKit
//  import NotificationToast

class EventDetailViewController: UIViewController {
    
    // MARK: 포스터 홈페이지 링크 버튼
    @IBOutlet weak var linkBtn: UIButton!
    // MARK: 포스터 일정 추가 버튼
    @IBOutlet weak var likeBtn: UIButton!
    // MARK: 일정 확정 버튼
    @IBOutlet weak var addDate: UIStackView!
    // MARK: segmentedControl
    @IBOutlet weak var eventDetailSegmentedControl: UISegmentedControl!
    // MARK: 포스터 공유 시트 버튼
    @IBAction func shareSheetBtn(_ sender: Any) {
        presentShareSheet()
    }
    
    // MARK: 토스트 팝업 버튼
//    @IBAction func toastPopUp(_ sender: Any) {
//        let toast = ToastView(
//            title: "토요국악",
//            titleFont: .systemFont(ofSize: 13, weight: .regular),
//            subtitle: "일정추가 완료 되었습니다.",
//            subtitleFont: .systemFont(ofSize: 11, weight: .light),
//            icon: UIImage(systemName: "calendar.badge.plus"),
//            iconSpacing: 16,
//            position: .top
//        )
//        toast.show()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDate.layer.cornerRadius = 15
        self.eventDetailSegmentedControl.frame = CGRect(x: self.eventDetailSegmentedControl.frame.minX, y: self.eventDetailSegmentedControl.frame.minY, width: eventDetailSegmentedControl.frame.width, height: 25)
        eventDetailSegmentedControl.highlightSelectedSegment()
    }
    
//    @IBAction func didChangeDetail(_ sender: Any) {
//
//    }
    
//    @IBAction func didChangeIndex(_ sender: UISegmentedControl) {
//        segmentedControl.underlinePosition()
//
//        switch sender.selectedSegmentIndex {
//        case 0:
//            keywordContainerView.alpha = 1
//            interestContainerView.alpha = 0
//            buttonState.setTitle("키워드 설정", for: .normal)
//            buttonState.tintColor = #colorLiteral(red: 0.7622407675, green: 0.1809852719, blue: 0.1365764439, alpha: 1)
//
//        case 1:
//            keywordContainerView.alpha = 0
//            interestContainerView.alpha = 1
//            buttonState.setTitle("목록 전체 삭제", for: .normal)
//            buttonState.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
//            buttonState.tintColor = #colorLiteral(red: 0.2941176471, green: 0.3568627451, blue: 0.6392156863, alpha: 1)
//        default:
//            break
//        }
//    }
    
    private func presentShareSheet() {
        guard let image = UIImage(systemName: "bell"), let url = URL(string: "https://www.daejeon.go.kr/kmusic/kmsPublicPerformanceView.do?pblprfrInfoId=1096&menuSeq=6400&searchAllPblprfrAt=&searchPastPblprfrAt=&searchPblprfrFormClCode=&pageIndex=") else {
            return
        }
        let shareSheetVC = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
}
