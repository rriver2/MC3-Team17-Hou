//
//  DetailLinkViewController.swift
//  Ninano
//
//  Created by 임영후 on 2022/07/18.
//

import UIKit
import WebKit

class DetailLinkViewController: UIViewController {

    @IBOutlet weak var detailWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://www.daejeon.go.kr/kmusic/kmsPublicPerformanceView.do?pblprfrInfoId=1096&menuSeq=6400&searchAllPblprfrAt=&searchPastPblprfrAt=&searchPblprfrFormClCode=&pageIndex="
        if let url = URL(string: urlString) {
            let urlReq = URLRequest(url: url)
            detailWebView.load(urlReq)
        }
    }
}
