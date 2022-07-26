//
//  ModalCalendarViewController.swift
//  Ninano
//
//  Created by 임영후 on 2022/07/19.
//

import UIKit

class ModalCalendarViewController: UIViewController {

    @IBOutlet weak var calendarFrame: UIView!
    @IBOutlet weak var addSchedule: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarFrame.layer.cornerRadius = 10
        addSchedule.layer.cornerRadius = 10
    }
}
