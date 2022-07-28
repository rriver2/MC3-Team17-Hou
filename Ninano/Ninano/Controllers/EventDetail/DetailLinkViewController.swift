//
//  DetailLinkViewController.swift
//  Ninano
//
//  Created by 임영후 on 2022/07/18.
//
//  웹뷰로 연결 시 사용

import UIKit
import WebKit

class DetailLinkViewController: UIViewController {

    @IBOutlet weak var detailWebView: WKWebView!
    
    var urlString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 가데이터
//        let urlString = "https://www.daejeon.go.kr/kmusic/kmsPublicPerformanceView.do?pblprfrInfoId=1096&menuSeq=6400&searchAllPblprfrAt=&searchPastPblprfrAt=&searchPblprfrFormClCode=&pageIndex="
//        if let url = URL(string: urlString) {
//            let urlReq = URLRequest(url: url)
//            detailWebView.load(urlReq)
//        }

        if let url = URL(string: urlString) {
            let urlReq = URLRequest(url: url)
            detailWebView.load(urlReq)
        }
    }
}
