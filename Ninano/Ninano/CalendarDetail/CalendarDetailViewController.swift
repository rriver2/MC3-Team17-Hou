//
//  CalendarDetailViewController.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/18.
//

import UIKit

class CalendarDetailViewController: UIViewController {
    var eventList = EventData().list
    var event: Event?
    
    var monthImage: UIImage?
    let eventPosters = ["banhyang", "guiTo"]
    var eventPoster: UIImage?
    
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

        return cell
    }
}
