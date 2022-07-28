//  백그라운드 블러 레퍼런스 / 토스트팝업 패키지
//  https://www.youtube.com/watch?v=AoyU-jsFqmI
//  https://github.com/PhilippeWeidmann/NotificationToast
//
//  ViewController.swift
//  Ninano
//
//  Created by 임영후 on 2022/07/11.
//

import UIKit
// MARK: 토스트 팝업 디팬던시
// import NotificationToast
                                        
class EventDetailViewController: UIViewController {
    
    // MARK: 검색에서 넘겨받은 정보들
    private var selectedCultureInfo: CulturalEventInfo?
    // MARK: 네비게이션 아이템
    @IBOutlet weak var naviItem: UINavigationItem!
    // MARK: 스크롤뷰
    @IBOutlet weak var scrollView: UIScrollView!
    // MARK: 포스터 홈페이지 링크 버튼
    @IBOutlet weak var linkBtn: UIButton!
    // MARK: 포스터 일정 추가 버튼
    @IBOutlet weak var likeBtn: UIButton!
    // MARK: 일정 확정 버튼
    @IBOutlet weak var addDate: UIButton!
    // MARK: segmentedControl
    @IBOutlet weak var eventDetailSegmentedControl: UISegmentedControl!
    // MARK: 포스터 공유 시트 버튼
    @IBAction func shareSheetBtn(_ sender: Any) {
        presentShareSheet()
    }
    
    // MARK: 토스트 팝업 버튼 (추후 사용예정)
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
        
        // MARK: 이벤트 타이틀 넘겨 받을 때
//        selectedCultureInfo?.row[title]
//
//        naviItem.title = selectedCultureInfo?.row[title]
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]

        // MARK: 네비게이션바 백그라운드 투명
        scrollView.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        addDate.layer.cornerRadius = 15
        setBlurEffect()
        self.eventDetailSegmentedControl.frame = CGRect(x: self.eventDetailSegmentedControl.frame.minX, y: self.eventDetailSegmentedControl.frame.minY, width: eventDetailSegmentedControl.frame.width, height: 25)
        eventDetailSegmentedControl.highlightSelectedSegment()
    }
    
    // MARK: 네비게이션바 원래대로
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = .clear
        UIApplication.shared.statusBarUIView?.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

    }
    // MARK: 일정추가 버튼 백그라운드 블러 효과
    func setBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = addDate.frame
        addDate.addSubview(visualEffectView)
    }
    
    // MARK: 공유하기 시트
    private func presentShareSheet() {
        guard let image = UIImage(systemName: "bell"), let url = URL(string: "https://www.daejeon.go.kr/kmusic/kmsPublicPerformanceView.do?pblprfrInfoId=1096&menuSeq=6400&searchAllPblprfrAt=&searchPastPblprfrAt=&searchPblprfrFormClCode=&pageIndex=") else {
            return
        }
        let shareSheetVC = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
}

// MARK: - Scroll View Delegate
extension EventDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 100
        print(offset)
        let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        let textColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
        if offset > 1 {
            offset = 1
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusBarUIView?.backgroundColor = color
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: textColor]
        } else {
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusBarUIView?.backgroundColor = color
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: textColor]
        }
    }
}
