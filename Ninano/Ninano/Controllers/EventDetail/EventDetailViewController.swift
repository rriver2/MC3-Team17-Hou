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
// import NotificationToast
                                        
class EventDetailViewController: UIViewController {
    // 네이게이션

    @IBOutlet weak var naviItem: UINavigationItem!
    
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
        
        naviItem.title = "토요 국악"
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]

        // 네비게이션
        scrollView.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        // 니가한거
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_: )))
//        self.view.addGestureRecognizer(panGestureRecognizer)
//        panGestureRecognizer.delegate = self
        
        addDate.layer.cornerRadius = 15
        setBlurEffect()
        self.eventDetailSegmentedControl.frame = CGRect(x: self.eventDetailSegmentedControl.frame.minX, y: self.eventDetailSegmentedControl.frame.minY, width: eventDetailSegmentedControl.frame.width, height: 25)
        eventDetailSegmentedControl.highlightSelectedSegment()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = .clear
        UIApplication.shared.statusBarUIView?.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

    }
    
    func setBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = addDate.frame
        addDate.addSubview(visualEffectView)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        var offset = scrollView.contentOffset.y / 150
//        if offset > 1 {
//            offset = 1
//            let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
//            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
//            self.navigationController?.navigationBar.backgroundColor = color
//            UIApplication.shared.statusBarView?.backgroundColor = color
//        } else {
//            let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
//            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
//            self.navigationController?.navigationBar.backgroundColor = color
//        }
//    }
//     네비게이션
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        if scrollView.contentOffset.y > 100 {
//            qweFunc()
        }
        print(scrollView.contentOffset.y)
    }
    private func qweFunc() {
        navigationController?.navigationBar.backgroundColor = .red
    }
    
// 여기까지
    private func presentShareSheet() {
        guard let image = UIImage(systemName: "bell"), let url = URL(string: "https://www.daejeon.go.kr/kmusic/kmsPublicPerformanceView.do?pblprfrInfoId=1096&menuSeq=6400&searchAllPblprfrAt=&searchPastPblprfrAt=&searchPblprfrFormClCode=&pageIndex=") else {
            return
        }
        let shareSheetVC = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
}

// MARK: - Gesture Delegate
//extension EventDetailViewController: UIGestureRecognizerDelegate {
//
//}

// MARK: - Scroll View Delegate
extension EventDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 100
        print(offset)
        let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        let textColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
        if offset > 1 {
            offset = 1
            
//            let textColor = UIColor(red: 0, green: 0, blue: 0, alpha: offset)
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
