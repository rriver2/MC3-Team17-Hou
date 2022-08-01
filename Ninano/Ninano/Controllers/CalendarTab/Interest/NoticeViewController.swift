//
//  NoticeViewController.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/14.
//

import UIKit

class NoticeViewController: UIViewController {
    
    var likeViewModel = LikeDataModel()
    
    @IBOutlet weak var keywordContainerView: UIView!
    @IBOutlet weak var interestContainerView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var buttonState: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    @IBAction func didChangeIndex(_ sender: UISegmentedControl) {
        segmentedControl.underlinePosition()
        
        switch sender.selectedSegmentIndex {
        case 0:
            keywordContainerView.alpha = 1
            interestContainerView.alpha = 0
            buttonState.setTitle("키워드 설정", for: .normal)
            buttonState.tintColor = #colorLiteral(red: 0.7622407675, green: 0.1809852719, blue: 0.1365764439, alpha: 1)
            
        case 1:
            keywordContainerView.alpha = 0
            interestContainerView.alpha = 1
            buttonState.setTitle("목록 전체 삭제", for: .normal)
            buttonState.tintColor = #colorLiteral(red: 0.2941176471, green: 0.3568627451, blue: 0.6392156863, alpha: 1)
        default:
            break
        }
    }
    
    @IBAction func moveNextButton(_ sender: UIButton) {
        
        switch keywordContainerView.alpha {
        case 1.0:
            print("Move to Keyword settings")
        case 0.0:
            let alert = UIAlertController(title: "관심 목록을 삭제합니다.", message: "지금 삭제하시면 현재까지 등록된 내용이 모두 삭제됩니다.", preferredStyle: .alert)
            let alertNo = UIAlertAction(title: "취소", style: .default, handler: nil)
            let alertYes = UIAlertAction(title: "삭제", style: .destructive) { _ in
                self.likeViewModel.removeAllLikeItems()
            }

            alert.addAction(alertYes)
            alert.addAction(alertNo)

            present(alert, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    @IBAction func cancelNoticeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension NoticeViewController {
    
    func layout() {
        keywordContainerView.alpha = 1.0
        interestContainerView.alpha = 0.0
        mainTitle.font = UIFont.preferredFont(forTextStyle: .title2, weight: .bold)
        self.segmentedControl.frame = CGRect(x: self.segmentedControl.frame.minX, y: self.segmentedControl.frame.minY, width: segmentedControl.frame.width, height: 25)
        segmentedControl.highlightSelectedSegment()
        buttonState.tintColor = #colorLiteral(red: 0.7622407675, green: 0.1809852719, blue: 0.1365764439, alpha: 1)
        buttonState.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { textBold in
            var result = textBold
            result.font = UIFont.preferredFont(forTextStyle: .body, weight: .bold)
            return result
        }
    }
}
