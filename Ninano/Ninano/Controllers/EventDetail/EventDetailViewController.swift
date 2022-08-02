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
// MARK: 토스트 팝업 디팬던시 추후 사용예정
// import NotificationToastz

class EventDetailViewController: UIViewController {
    
    var LIKEVIEWMODEL = LikeDataModel()
    var event: Event?
    private var likeManager =  LikeManager.shared
    private var reserveManager = ReserveManager.shared
    // MARK: 현재 이벤트가 저장되어있는지 확인
    private var isLiked: Bool {
        likeManager.getLike().filter { $0.url == event?.URL }.isEmpty
    }
    // MARK: 현재 이벤트가 예약되어있는지 확인
    private var isReserved: Bool {
        !reserveManager.getReserve().filter { $0.url == event?.URL }.isEmpty
    }

    // MARK: 포스터 이미지
    @IBOutlet weak var eventPosterImageView: UIImageView!
    // MARK: 네비게이션 아이템
    @IBOutlet weak var naviItem: UINavigationItem!
    // MARK: 스크롤뷰
    @IBOutlet weak var scrollView: UIScrollView!
    // MARK: 포스터 일정 추가 버튼
    @IBOutlet weak var likeBtn: UIButton!
    // MARK: segmentedControl
    @IBOutlet weak var eventDetailSegmentedControl: UISegmentedControl!
    // MARK: 일정 추가 및 삭제 버튼
    @IBOutlet weak var reserveBtn: UIButton!
    
    @IBOutlet private weak var eventTitleLabel: UILabel!
    @IBOutlet private weak var eventPlaceLabel: UILabel!
    @IBOutlet private weak var eventDateLabel: UILabel!
    @IBOutlet private weak var eventPriceLabel: UILabel!
    @IBOutlet private weak var eventInfoLabel: UILabel!
    @IBOutlet private weak var eventActorLabel: UILabel!
    
    @IBAction func linkButtonPressed(_ sender: UIButton) {
        if let eventURL = event?.URL {
            guard let urlString = URL(string: eventURL),
                  UIApplication.shared.canOpenURL(urlString) else { return }
            UIApplication.shared.open(urlString, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if isLiked {
            let newLikeModel = LikeModel(nameLike: event!.title, isLiked: false, url: (event?.URL!)!)
            likeManager.insertLike(newLikeModel)
        } else {
            likeManager.deleteLike(with: (event?.URL!)!)
        }
        chooseLikeBtnColor()
    }
    
    @IBAction func reserveButtonPressed(_ sender: UIButton) {
        if isReserved {
            if let event = event {
                reserveManager.deleteReserve(with: event.URL!)
            }
            drawReserveButton()
        } else {
            guard let modalCalendarVC = UIStoryboard(name: "EventDetail", bundle: .main).instantiateViewController(withIdentifier: "modalCalendarVC") as? ModalCalendarViewController else { return }
            modalCalendarVC.event = self.event
            modalCalendarVC.parentVC = self
            self.present(modalCalendarVC, animated: true, completion: nil)
        }
    }
    
    // MARK: 포스터 공유 시트 버튼
    @IBAction func shareSheetBtn(_ sender: Any) {
        presentShareSheet()
    }
    
    // MARK: segmentedControl
    @IBAction func didChangeIndex(_ sender: UISegmentedControl) {
        eventDetailSegmentedControl.underlinePosition()
        
        switch sender.selectedSegmentIndex {
        case 0:
            eventPriceLabel.alpha = 1
            eventInfoLabel.alpha = 0
            eventActorLabel.alpha = 0
            
        case 1:
            eventPriceLabel.alpha = 0
            eventInfoLabel.alpha = 1
            eventActorLabel.alpha = 0
            
        case 2:
            eventPriceLabel.alpha = 0
            eventInfoLabel.alpha = 0
            eventActorLabel.alpha = 1
            
        default:
                break
        }
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
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawReserveButton()
        // MARK: 일정추가 버튼 백그라운드 블러 효과 안녕...추후 다시 도전해볼게요..
//        setBlurEffect()
        chooseLikeBtnColor()
        didTapCustomBackButton()
        selectedEventInfo()
        layout()
        
        // MARK: 네비게이션바 백그라운드 투명
        scrollView.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
        reserveBtn.layer.cornerRadius = 17.5
    }
    
    // MARK: 네비게이션바 원래대로
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = .clear
        UIApplication.shared.statusBarUIView?.backgroundColor = .clear
    }
    
    // MARK: 네비게이션 컨트롤러 백버튼 히든
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: 일정추가 버튼 백그라운드 블러 효과 안녕...추후 다시 도전해볼게요..
//    func setBlurEffect() {
//        reserveBtn.layer.cornerRadius = 17.5
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.alpha = 0.5
//        blurEffectView.frame = self.reserveBtn.bounds
//        self.reserveBtn.addSubview(blurEffectView)
//    }
    
    // MARK: 공유하기 시트
    private func presentShareSheet() {
        if let eventURL = event?.URL {
            guard let url = URL(string: eventURL) else {
                return
            }
            let shareSheetVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            present(shareSheetVC, animated: true)
        }
    }
    
    // MARK: 백버튼
    private func didTapCustomBackButton() {
        var backImage = UIImage(named: "backIcon")
        backImage = backImage?.resizeImage(newWidth: 35)
        
        let backButton = UIButton()
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        let backBtn = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBAction func LIKEBUTTON(_ sender: UIButton) {
        LIKEVIEWMODEL.addLikeItems(url: event?.URL ?? "", isLiked: true, name: event?.title ?? "")
        print("오호이")
    }
    
    // MARK: event model
    private func selectedEventInfo() {
        guard let event = event else {
            return
        }
        naviItem.title = event.title
        eventTitleLabel.text = event.title
        eventPlaceLabel.text = event.place
        eventDateLabel.text = event.period
        eventPriceLabel.text = event.price == "" ? "해당 정보 없음" : event.price
        eventInfoLabel.text = event.info == "" ? "해당 정보 없음" : event.info
        eventActorLabel.text = event.actor == "" ? "해당 정보 없음" : event.actor

        do {
            let data = try Data(contentsOf: event.posterURL!)
            eventPosterImageView.image = UIImage(data: data)
        } catch {
            print("Error URL to Data : \(error)")
        }
    }

    // MARK: 저장버튼 토글 시 변환
    private func chooseLikeBtnColor() {
        if isLiked {
            likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            likeBtn.tintColor = .gray
        } else {
            likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeBtn.tintColor = .red
        }
    }
    
    // MARK: 일정추가 버튼 토글 시 변환
    func drawReserveButton() {
        if isReserved {
            reserveBtn.titleLabel?.font = .boldSystemFont(ofSize: 13)
            reserveBtn.setTitle("일정 제거", for: .normal)
            reserveBtn.setTitleColor(.red, for: .normal)
            reserveBtn.setImage(
                UIImage(
                    systemName: "calendar.badge.minus",
                    withConfiguration: UIImage.SymbolConfiguration(
                        paletteColors: [.red])
                ),
                for: .normal
            )
            reserveBtn.backgroundColor = CustomColor.c5?.withAlphaComponent(0.9)
        } else {
            reserveBtn.titleLabel?.font = .boldSystemFont(ofSize: 13)
            reserveBtn.setTitle("일정 추가", for: .normal)
            reserveBtn.setTitleColor(.black, for: .normal)

            reserveBtn.setImage(
                UIImage(
                    systemName: "calendar.badge.plus",
                    withConfiguration: UIImage.SymbolConfiguration(
                        paletteColors: [.red])
                ),
                for: .normal
            )
            reserveBtn.backgroundColor =
                CustomColor.buttonLightGray?.withAlphaComponent(0.9)
        }
    }
}

// MARK: - Scroll View Delegate
extension EventDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 100
        let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        let textColor = UIColor(red: 0, green: 0, blue: 0, alpha: offset)
        
        if offset > 1 {
            offset = 1
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusBarUIView?.backgroundColor = color
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: textColor]
        } else {
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusBarUIView?.backgroundColor = color
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: textColor]
        }
    }
}

// MARK: - layout
extension EventDetailViewController {
    
    func layout() {
        eventPriceLabel.alpha = 1
        eventInfoLabel.alpha = 0
        eventActorLabel.alpha = 0
        self.eventDetailSegmentedControl.frame = CGRect(x: self.eventDetailSegmentedControl.frame.minX, y: self.eventDetailSegmentedControl.frame.minY, width: eventDetailSegmentedControl.frame.width, height: 25)
        eventDetailSegmentedControl.highlightSelectedSegment()
    }
}
