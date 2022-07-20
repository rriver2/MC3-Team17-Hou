//
//  CalendarDetailViewController.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/18.
//

import UIKit

class CalendarDetailViewController: UIViewController {
    private var eventList = EventData().list
    private var event: Event?
    
    private var monthImage: UIImage?
    private let eventPosters = ["banhyang", "guiTo"]
    private var eventPoster: UIImage?

    private var heartConfig = UIImage.SymbolConfiguration(paletteColors: [.systemRed])
    private let heartSymbol = UIImage(systemName: "heart.fill")
    
    private var calConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
    private let calSymbol = UIImage(systemName: "calendar.badge.clock")
    
    @IBOutlet weak var monthImageView: UIImageView!
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var dayEventDetailView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        monthImage = UIImage(named: "JulyBG")
        monthImageView.image = monthImage
        topBackground.layer.cornerRadius = 25
        self.dayEventDetailView.backgroundColor = .clear
        
        setBlurEffect()
    }
    
    func setBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        monthImageView.addSubview(visualEffectView)
        visualEffectView.frame = monthImageView.frame
    }
}

extension CalendarDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayEventDetailCell", for: indexPath) as? DayEventDetailCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.selectedBackgroundView = UIView()
        
        eventPoster = UIImage(named: "\(eventPosters[indexPath.row])")
        cell.posterImage.image = eventPoster
        cell.posterImage.layer.cornerRadius = 10
        
        let eventData = eventList[indexPath.row]
        cell.eventNameLabel.text = eventData.eventName
        cell.eventPlaceLabel.text = eventData.eventPlace
        cell.eventPeriodLabel.text = eventData.eventPeriod
        cell.eventTimeLabel.text = eventData.eventTime
        
        cell.planned.image = calSymbol
        cell.planned.preferredSymbolConfiguration = calConfig
        
        heartConfig = heartConfig.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))
        cell.liked.image = heartSymbol
        cell.liked.preferredSymbolConfiguration = heartConfig
        cell.liked.alpha = eventData.isLiked == true ? 1.0 : 0.0
        
        return cell
    }
}
