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
    private var eventPoster: UIImage?
    
    private var weekdays: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    private var dates: [String] = ["17", "18", "19", "20", "21", "22", "23"]
    
    private var month: String = "7월"
    private var backButton = UIImage.SymbolConfiguration(paletteColors: [.black])
    private let backSymbol = UIImage(systemName: "chevron.left")
    
    private var heartConfig = UIImage.SymbolConfiguration(paletteColors: [.systemRed])
    private let heartSymbol = UIImage(systemName: "heart.fill")
    
    private var calConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
    private let calSymbol = UIImage(systemName: "calendar.badge.clock")
    
    @IBOutlet weak var monthBackButton: UIButton!
    @IBOutlet weak var monthImageView: UIImageView!
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var weeklyCalendarView: UICollectionView!
    @IBOutlet weak var dayEventDetailView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var backButtonConfig = UIButton.Configuration.plain()
        backButtonConfig.title = month
        backButtonConfig.image = backSymbol
        backButtonConfig.imagePlacement = .leading
        backButtonConfig.imagePadding = 15
        backButtonConfig.baseForegroundColor = UIColor.black
        backButtonConfig.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
        backButton = backButton.applying(UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
//        monthBackButton.configuration = backButtonConfig
//        monthBackButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
//        monthBackButton.imageView?.preferredSymbolConfiguration = backButton
        
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

extension CalendarDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weeklyCalendarCell", for: indexPath) as? WeeklyCalendarCell else {
            return UICollectionViewCell()
        }
        
        cell.dayNameLabel.text = weekdays[indexPath.row]
        cell.dateNumberLabel.text = dates[indexPath.row]
        
        return cell
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
        
        let eventData = eventList[indexPath.row]
        
        eventPoster = UIImage(named: "\(eventData.eventPosterName)")
        cell.posterImage.image = eventPoster
        cell.posterImage.layer.cornerRadius = 10

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
