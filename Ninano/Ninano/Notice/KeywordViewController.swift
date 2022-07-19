//
//  KeywordViewController.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/14.
//

import UIKit

class KeywordViewController: UIViewController {
    
    @IBOutlet weak var keywordTableView: UITableView!
    
    let img = ["flag", "flag.fill", "star", "star.fill"]
    let keywordDate = ["7월 24일 (일요일)", "7월 28일 (목요일)", "7월 31일 (일요일)", "8월 15일 (월요일)"]
    let keywordTitle = ["깃발과 백설", "흑깃", "별이 흐르는 시간", "별은 사실 그 자리에 있지 않다."]
    let alarmTitle = "레버 관심설정의 새로운 공연일정이 추가되었습니다."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
        keywordTableView.rowHeight = 90
    }
}

extension KeywordViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noticeKeyword", for: indexPath) as? KeywordTableViewCell else { return UITableViewCell.init() }
        
        cell.keywordImage.image = UIImage(systemName: img[indexPath.row])
        cell.keywordTitle.text = keywordTitle[indexPath.row]
        cell.keywordAlarmTitle.text = alarmTitle
        cell.keywordDate.text = keywordDate[indexPath.row]
        
        return cell
    }
}
