//
//  CalenderViewController.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/19.
//

import UIKit

final class CalenderViewController: UIViewController {
    @IBAction func clickedScheduleButton(_ sender: UIButton) {
        // TODO: 날짜 기입 
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var scheduleButton: UIButton!
    @IBOutlet weak var calendarFrame: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleButton.layer.cornerRadius = 10
        calendarFrame.layer.cornerRadius = 10
    }
    
}
