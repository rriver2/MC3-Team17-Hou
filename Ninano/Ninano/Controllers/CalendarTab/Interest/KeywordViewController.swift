//
//  KeywordViewController.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/14.
//

import UIKit

class KeywordViewController: UIViewController {
    
    @IBOutlet weak var keywordTableView: UITableView!
    
    let img = ["22008595_p", "22007929_p", "22005098_p"]
    let keywordDate = ["3시간 전", "5일 전", "7월 31일 (일요일)"]
    let keywordTitle = ["깃발과 백설", "흑깃", "별이 흐르는 시간"]
    let alarmTitle = "레버 관심설정의 새로운 공연일정이 추가되었습니다."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
}

extension KeywordViewController {
    
    func layout() {
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
        keywordTableView.rowHeight = 90
        keywordTableView.separatorStyle = .none
        keywordTableView.showsVerticalScrollIndicator = false
    }
}

extension KeywordViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noticeKeyword", for: indexPath) as? KeywordTableViewCell else { return UITableViewCell.init() }
        
        cell.keywordImage.image = UIImage(named: img[indexPath.row])
        cell.keywordImage.layer.cornerRadius = 15
        cell.keywordTitle.text = keywordTitle[indexPath.row]
        cell.keywordTitle.font = UIFont.boldSystemFont(ofSize: 17)
        cell.keywordAlarmTitle.text = alarmTitle
        cell.keywordDate.text = keywordDate[indexPath.row]
        cell.keywordBackgroundCell.layer.cornerRadius = 15
        
        return cell
    }
}
