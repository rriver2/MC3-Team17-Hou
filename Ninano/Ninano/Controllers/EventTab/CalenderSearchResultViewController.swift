//
//  CalenderViewController.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/19.
//

import UIKit

final class CalenderSearchResultViewController: UIViewController {
    
    @IBOutlet weak var scheduleButton: UIButton!
    @IBOutlet weak var calendarFrame: UIView!
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    weak var delegate: DateDelivable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleButton.layer.cornerRadius = 10
        calendarFrame.layer.cornerRadius = 10
    }
    
    private func convertDateToKoreanDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        let koreanDate = formatter.string(from: dataPicker.date)
        return koreanDate
    }
    
    @IBAction func clickedScheduleButton(_ sender: UIButton) {
        // TODO: 날짜 기입 
        self.dismiss(animated: true, completion: nil)
        let koreanDate = convertDateToKoreanDate(date: dataPicker.date)
        delegate?.addDate(date: koreanDate)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
