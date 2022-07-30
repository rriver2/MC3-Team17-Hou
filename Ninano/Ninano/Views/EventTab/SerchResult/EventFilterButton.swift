//
//  EventFilterButton.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/25.
//

import UIKit

class EventFilterButton: UIView {
    
    @IBOutlet private weak var localFilterButton: UIButton!
    @IBOutlet weak var dateFilterButton: UIButton!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        localFilterButton.configuration?.baseBackgroundColor = CustomColor.buttonLightGray
        dateFilterButton.configuration?.baseBackgroundColor = CustomColor.buttonLightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "EventFilterButton", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    weak var datedeliveryDelegate: EventButtonFilterable?
    
    private enum Filter {
        case local
        case category
        case date
    }
    
    var local: [String] = []
    
    @IBAction private func localFilterButton(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "지역 선택", message: "공연 정보를 나타낼 지역을 설정해주세요.", preferredStyle: .actionSheet)
        let locals: [String] = local
        for location in locals {
            actionSheet.addAction(UIAlertAction(title: location, style: .default, handler: { _ in
                let attribute = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)]
                self.datedeliveryDelegate?.filterCollctionCell(criteria: .local(location))
                if location == "전체" {
                    sender.configuration?.baseBackgroundColor = CustomColor.buttonLightGray
                    let attributedTitle = NSAttributedString(string: "지역 선택", attributes: attribute)
                    sender.setAttributedTitle(attributedTitle, for: .normal)
                } else {
                    sender.configuration?.baseBackgroundColor = CustomColor.buttonLightRed
                    let attributedTitle = NSAttributedString(string: location, attributes: attribute)
                    sender.setAttributedTitle(attributedTitle, for: .normal)
                }
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        datedeliveryDelegate?.openLocalActionSheet(actionSheet: actionSheet)
    }
    
    @IBAction private func dateFilterButton(_ sender: UIButton) {
        datedeliveryDelegate?.openCaledarSearchResultView()
    }
}
