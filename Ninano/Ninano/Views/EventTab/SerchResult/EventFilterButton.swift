//
//  EventFilterButton.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/25.
//

import UIKit

class EventFilterButton: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "EventFilterButton", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    
    
    
    weak var datedeliveryDelegate: FilterButtonClickable?
    
    private var selectedLocal: LocationType? {
        didSet {
            // TODO: 밑에 공연 filtering
            print("local inited: \(selectedLocal?.rawValue ?? "")")
        }
    }
    private enum Filter {
        case local
        case category
        case date
    }

    private enum LocationType: String {
        case gangnam = "강남"
        case gangbook = "강북"
        case gurogu = "구로구"
        case gwanakgu = "관악구"
        case gwangjingu = "광진구"
        case dobonggu = "도봉구"
        case nowongu = "노원구"
    }

    @IBAction func localFilterButton(_ sender: UIButton) {
        print("localFilterButton")
        let actionSheet = UIAlertController(title: "지역 선택", message: "공연 정보를 나타낼 지역을 설정해주세요.", preferredStyle: .actionSheet)
        let locals: [LocationType] = [.gangnam, .gangbook, .gurogu, .gwanakgu, .gwangjingu, .dobonggu, .nowongu]
        for local in locals {
            let location = local.rawValue
            actionSheet.addAction(UIAlertAction(title: location, style: .default, handler: { [self] _ in
                datedeliveryDelegate?.clickedFilterButtonColorChange(sender)
                sender.titleLabel?.text = location
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        datedeliveryDelegate?.closeActionSheet(actionSheet: actionSheet)
    }
    
    @IBAction func dateFilterButton(_ sender: UIButton) {
        print("dateFilterButton")
        datedeliveryDelegate?.openCaledarSearchResultView()
    }
}
