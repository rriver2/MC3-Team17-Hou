//
//  CalendarDetailViewController.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/18.
//
import UIKit

class CalendarDetailViewController: UIViewController {
    
    private var monthImage: UIImage?
    
    private var weekdays: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    var dates: [String] = []
    var yearString: String = ""
    var monthString: String = ""
    
    let now = Date()
    var cal = Calendar.current
    // 해달 월에 몇일까지 있는지 카운트
    var daysCountInMonth = 0
    var components = DateComponents()
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var alertEmptyEventLabel: UILabel!
    private var selectedCell: Int?
    
    private var backButton = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
    private let backSymbol = UIImage(systemName: "chevron.left")
    
    private var heartConfig = UIImage.SymbolConfiguration(paletteColors: [.systemRed])
    private let heartSymbol = UIImage(systemName: "heart.fill")
    
    private var calConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
    private let calSymbol = UIImage(systemName: "calendar.badge.clock")
    
    private let calInset: CGFloat = 15.0
    
    private var articles: APIResponse?
    private var eventList = [Event]()
    var selectedEventList: [Event] = []
    var selectedDate: Date? {
        didSet {
            filterDate()
        }
    }
    
    func filterDate() {
        // date 정제
        if let compareDate = self.selectedDate { // compareDate는 이번에 선택한 애
            print("$0.perioddd", eventList.count)
            selectedEventList = eventList.filter {
                if let period = $0.period {
                    let dateList = period.periodToDateList()
                    if dateList.count == 1 {
                        if dateList[0].isDateToday(fromDate: compareDate) {
                            return true
                        } else {
                            return false
                        }
                    } else {
                        let range = dateList[0]...dateList[1]
                        if range.contains(compareDate) {
                            return true
                        } else {
                            return false
                        }
                    }
                }
                return false
            }
        }
        weeklyCalendarView.reloadData()
        dayEventDetailView.reloadData()
    }
    
    @IBOutlet weak var monthImageView: UIImageView!
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var weeklyCalendarView: UICollectionView!
    @IBOutlet weak var dayEventDetailView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationTitle()
        didTapCustomBackButton()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: calInset, bottom: 0, right: calInset)
        weeklyCalendarView.collectionViewLayout = flowLayout
        
        monthImage = UIImage(named: "calendarBackground")
        monthImageView.image = monthImage
        topBackground.layer.cornerRadius = 25
        self.dayEventDetailView.backgroundColor = .clear
        setBlurEffect()
        fetchTopStories()
        selectedCell = 0
        selectedDate = dayToDate(day: dates[0])
        alertEmptyEventLabel?.isHidden = false
    }
    
    private func dayToDate(day: String) -> Date {
        let dateString = yearString + "-" + monthString + "-" + day
        return dateString.toDate() ?? Date()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        print(date)
    }
    
    private func configNavigationTitle() {
        let calendarTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        calendarTitle.textAlignment = .center
        calendarTitle.font = UIFont.boldSystemFont(ofSize: 25)
        calendarTitle.text = monthString + "月"
        self.navigationItem.titleView = calendarTitle
        
    }
    
    private func didTapCustomBackButton() {
        var backImage = UIImage(systemName: "chevron.backward.square.fill")
        backImage = backImage?.resizeImage(newWidth: 40)
        let undo = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.leftBarButtonItem = undo
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "D15353")
    }
    
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        monthImageView.addSubview(visualEffectView)
        visualEffectView.frame = monthImageView.frame
    }
    
    @IBAction func addDate(_ sender: Any) {
        guard let eventDetailView = UIStoryboard(name: "EventDetail", bundle: .main).instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController else { return }
        eventDetailView.event = selectedEventList[0]
        self.navigationController?.pushViewController(eventDetailView, animated: true)
    }
    
    private func reloadCollection() {
        var filterDateEvent: [Event] = selectedEventList
        // date 정제
        if let compareDate = self.selectedDate {
            filterDateEvent = filterDateEvent.filter {
                if let period = $0.period {
                    let dateList = period.periodToDateList()
                    for date in dateList {
                        if date.isDateToday(fromDate: compareDate) {
                            return true
                        } else {
                            return false
                        }
                    }
                }
                return false
            }
        }
        // collectionView update
        selectedEventList = filterDateEvent
        dayEventDetailView.reloadData()
        
        if selectedEventList.isEmpty {
            alertEmptyEventLabel?.isHidden = false
        } else {
            alertEmptyEventLabel?.isHidden = true
        }
    }
}

extension CalendarDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekdays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weeklyCalendarCell", for: indexPath) as? WeeklyCalendarCell else {
            return UICollectionViewCell()
        }
        
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        
        let firstDayOfMonth = cal.date(from: components)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth ?? Date())!.count
        //        self.monthString = dateFormatter.string(from: firstDayOfMonth!)
        
        cell.dayHighlight.layer.cornerRadius = 14.5
        cell.dayNameLabel.text = weekdays[indexPath.row]
        
        if Int(dates[indexPath.row]) ?? 0 <= daysCountInMonth {
            cell.dateNumberLabel.text = dates[indexPath.row]
        }
        
        if indexPath.row == selectedCell {
            cell.dayHighlight.alpha = 1.0
            cell.dayNameLabel.textColor = .white
            cell.dateNumberLabel.textColor = .white
        } else {
            cell.dayHighlight.alpha = 0.0
            cell.dayNameLabel.textColor = .black
            cell.dateNumberLabel.textColor = .black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        selectedDate = dayToDate(day: dates[indexPath.row])
    }
}

extension CalendarDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        flow.minimumInteritemSpacing = 5
        let width = (UIScreen.main.bounds.width - (calInset * 2)) / CGFloat(weekdays.count) - flow.minimumInteritemSpacing
        
        return CGSize(width: width, height: 52)
    }
}

extension CalendarDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedEventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayEventDetailCell", for: indexPath) as? DayEventDetailCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.selectedBackgroundView = UIView()
        if let posterDate = selectedEventList[indexPath.row].posterData {
            cell.posterImage.image = UIImage(data: posterDate)
        } else {
            cell.posterImage.image = UIImage(named: "tempPoster")
        }
        cell.posterImage.layer.cornerRadius = 10
        
        cell.eventNameLabel.text = selectedEventList[indexPath.row].title
        cell.eventPlaceLabel.text = selectedEventList[indexPath.row].place
        cell.eventPeriodLabel.text = selectedEventList[indexPath.row].period
        return cell
    }
    
    func fetchTopStories() {
        
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
                case .success(let articles):
                    self?.articles = articles
                    self?.eventList = articles.culturalEventInfo.row.compactMap({
                        Event(
                            title: String($0.title),
                            posterURL: URL(string: ($0.mainImg ?? "") + "djks"),
                            place: String($0.place),
                            area: String($0.guname),
                            period: String($0.date),
                            URL: String($0.orgLink ?? ""),
                            actor: String($0.player),
                            info: String($0.program),
                            price: String($0.useFee)
                        )
                    })
                    DispatchQueue.main.async {
                        self?.selectedEventList = self?.eventList ?? []
                        self?.dayEventDetailView.reloadData()
                        self?.filterDate()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
