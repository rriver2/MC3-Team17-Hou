//
//  ViewController.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var linkBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var shareSheetBtn: UIButton!
    
    // 모달 뷰 코드로 구현 시
//    @IBAction func addCalendarBtn() {
//        guard let calendarBtn = storyboard?.instantiateViewController(identifier: "modalCalendarVC") as? ModalCalendarViewController else {
//            return
//        }
//        present(calendarBtn, animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareSheetBtn.addTarget(self, action: #selector(presentShareSheet), for: .touchUpInside)
        linkBtn.layer.cornerRadius = 20
        likeBtn.layer.cornerRadius = 20
        view.addSubview(shareSheetBtn)
    }
    
    @objc private func presentShareSheet() {
        guard let image = UIImage(systemName: "bell"), let url = URL(string: "https://www.daejeon.go.kr/kmusic/kmsPublicPerformanceView.do?pblprfrInfoId=1096&menuSeq=6400&searchAllPblprfrAt=&searchPastPblprfrAt=&searchPblprfrFormClCode=&pageIndex=") else {
            return
        }
        let shareSheetVC = UIActivityViewController(activityItems: [image,url], applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
}
