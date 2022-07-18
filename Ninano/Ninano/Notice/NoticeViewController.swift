//
//  NoticeViewController.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/14.
//

import UIKit

class NoticeViewController: UIViewController {
    
    @IBOutlet weak var keywordContainerView: UIView!
    @IBOutlet weak var interestContainerView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var buttonState: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keywordContainerView.alpha = 1.0
        interestContainerView.alpha = 0.0
        buttonState.tintColor = #colorLiteral(red: 0.7622407675, green: 0.1809852719, blue: 0.1365764439, alpha: 1)
    }

    @IBAction func didChangeIndex(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            keywordContainerView.alpha = 1
            interestContainerView.alpha = 0
            buttonState.setTitle("키워드 설정", for: .normal)

        case 1:
            keywordContainerView.alpha = 0
            interestContainerView.alpha = 1
            buttonState.setTitle("목록 전체 삭제", for: .normal)
//            buttonState.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)

        default:
            break
        }
    }
    
    @IBAction func bottomTappedChange(_ sender: UIButton) {
//        switch keywordContainerView.alpha {
//        case 1.0:
//
//        case 0.0:
//
//        default:
//            break
//        }
    }
    
    @IBAction func noticeOutTapped(_ sender: UIButton) {
    
    }
}
