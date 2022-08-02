//
//  CalendarDetailViewController.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/18.
//
import UIKit

class CalendarDetailViewController: UIViewController {
    
    private var monthImage: UIImage?
    
    private var weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
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
        
        if selectedEventList.isEmpty {
            alertEmptyEventLabel?.isHidden = false
        } else {
            alertEmptyEventLabel?.isHidden = true
        }
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
        alertEmptyEventLabel?.isHidden = true
        dayEventDetailView.contentInset.top = 15
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
        calendarTitle.text = monthString + "월"
        calendarTitle.font = UIFont.preferredFont(forTextStyle: .title3, weight: .semibold)
        self.navigationItem.titleView = calendarTitle
    }
    
    @IBOutlet weak var addSchedule: UIButton!
    private func didTapCustomBackButton() {
        var backImage = UIImage(named: "backIcon")
        backImage = backImage?.resizeImage(newWidth: 35)
        
        let backButton = UIButton()
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        let backBtn = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBtn
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
    @IBAction func addSchedule(_ sender: UIButton) {
        if sender.titleLabel?.text == "일정 추가" {
            guard let calenderModal = UIStoryboard(name: "CalenderModal", bundle: .main).instantiateViewController(withIdentifier: "CalenderModalViewController") as? CalenderModalViewController else { return }
            self.present(calenderModal, animated: true, completion: nil)
            let attribute = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote, weight: .bold)]
            let attributedTitle = NSAttributedString(string: "일정 제거", attributes: attribute)
            sender.setAttributedTitle(attributedTitle, for: .normal)
            sender.backgroundColor = CustomColor.buttonLightGray
            sender.configuration?.baseForegroundColor = CustomColor.mainMidRed
            sender.setImage(
                UIImage(
                    systemName: "calendar.badge.minus",
                    withConfiguration: UIImage.SymbolConfiguration(
                        paletteColors: [CustomColor.mainMidRed!])
                ),
                for: .normal
            )
            
        } else if sender.titleLabel?.text == "일정 제거" {
            sender.setImage(UIImage(systemName: "calendar.bedge.plus"), for: .normal)
            let attribute = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote, weight: .bold)]
            let attributedTitle = NSAttributedString(string: "일정 추가", attributes: attribute)
            sender.setAttributedTitle(attributedTitle, for: .normal)
            sender.backgroundColor = CustomColor.mainMidRed
            sender.configuration?.baseForegroundColor = UIColor.white
            sender.setImage(
                UIImage(
                    systemName: "calendar.badge.minus",
                    withConfiguration: UIImage.SymbolConfiguration(
                        paletteColors: [UIColor.white])
                ),
                for: .normal
            )
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
        
        cell.dayHighlight.layer.cornerRadius = 14.5
        cell.dayNameLabel.text = weekdays[indexPath.row]
        cell.dayNameLabel.font = UIFont.preferredFont(forTextStyle: .caption2, weight: .bold)
        
        if Int(dates[indexPath.row]) ?? 0 <= daysCountInMonth {
            cell.dateNumberLabel.text = dates[indexPath.row]
            cell.dateNumberLabel.font = UIFont.preferredFont(forTextStyle: .caption2, weight: .bold)
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
        cell.configure(with: selectedEventList[indexPath.row])
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
