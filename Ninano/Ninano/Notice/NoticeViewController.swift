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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keywordContainerView.alpha = 1.0
        interestContainerView.alpha = 0.0
        
    }

    @IBAction func didChangeIndex(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            keywordContainerView.alpha = 1
            interestContainerView.alpha = 0
        case 1:
            keywordContainerView.alpha = 0
            interestContainerView.alpha = 1
        default:
            break
        }
    }
    
    @IBAction func noticeOutTapped(_ sender: UIButton) {
    
    }
}
