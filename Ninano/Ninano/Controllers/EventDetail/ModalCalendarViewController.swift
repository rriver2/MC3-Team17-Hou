//
//  ModalCalendarViewController.swift
//  Ninano
//
//  Created by 임영후 on 2022/07/19.
//

import UIKit

class ModalCalendarViewController: UIViewController {
    
    var event: Event?
    var parentVC: UIViewController?
    private var reserveManager = ReserveManager.shared
    private var selectedDate: Date?
    
    @IBOutlet weak var calendarFrame: UIView!
    @IBOutlet weak var addSchedule: UIButton!
    @IBAction func cancleBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePicked(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    @IBAction func confirmBtnPressed(_ sender: UIButton) {
        if let event = event {
            let reserveModel = ReserveModel(reserveDate: selectedDate, isReserved: true, url: event.URL!)
            reserveManager.insertReserve(reserveModel)
        }
        guard let vc = self.parentVC as? EventDetailViewController else { return }
        vc.drawReserveButton()
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarFrame.layer.cornerRadius = 10
        addSchedule.layer.cornerRadius = 10
    }
}
