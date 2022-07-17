//
//  SearchViewController.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/16.
//

import UIKit

class SearchViewController: UIViewController {
    let categoryList = ["내가 좋아할 만한 공연", "이번 달 예정 공연", "근처 공연", "국악", "무용"]
    var categoryConfig = UIButton.Configuration.plain()
    var categoryFont = UIFont.boldSystemFont(ofSize: 15)

    @IBOutlet var categoryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryCell else {
            return UITableViewCell()
        }
        categoryConfig.title = categoryList[indexPath.row]
        cell.categoryName.configuration = categoryConfig
        cell.categoryName.titleLabel?.font = categoryFont
        cell.categoryChevron.titleLabel?.font = categoryFont
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
    }
}
