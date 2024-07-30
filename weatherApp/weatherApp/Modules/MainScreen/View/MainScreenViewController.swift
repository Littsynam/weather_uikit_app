//
//  MainScreenViewController.swift
//  weatherApp
//
//  Created by Mastery on 08.07.2024.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tmperatureLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textConditionLabel: UILabel!
    // 1 - надо реализовать переменную
    var city = ""
    
    private var forecastDays: [Forecast.ForecastDay] = []
    
    private let presenter = MainScreenPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultView()
        presenter.delegate = self
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 2 - надо загрузить данные в переменную из UserDefaults
        // Именно до всех функций
        city = UserDefaults.standard.string(forKey:"city") ?? ""
        
        // 3 - надо из переменной поставить значение для label
//        cityLabel.text = "City: \(переменная)"
        cityLabel.text = "City: \(city)"
    }
    
    
    @IBAction func getTemperatureButtonTap(_ sender: Any) {
        // 4 - надо изменить и не из textField а переменную проверять и передавать в searchInfo
        if city != "" {
            presenter.searchInfo(by: city)
        }
    }
}
 
// MARK: - MainScreenPresenterOutput
extension MainScreenViewController: MainScreenPresenterOutput {
    
    func onLoadTemperature(temperature: Response) {
        
        let temp = temperature.current.temperatureInCelsius
        tmperatureLabel.text = "Temperature: \n \(temp) C"
        setTemperatyreIcon(by: temp)
        
        textConditionLabel.text = temperature.current.condition.text
    }
    
    func onLoadForecast(forecast: Forecast) {
        
        forecastDays = forecast.forecastday
        collectionView.reloadData()
    }
}

// MARK: - Private
private extension MainScreenViewController{
    
    func setTemperatyreIcon(by temperature: Double) {
        switch temperature{
        case ...(-20) :
            imageView.image = UIImage(named: "veryCold_icon")
        case -20...(-10) :
            imageView.image = UIImage(named: "coldly_icon")
        case -10...0 :
            imageView.image = UIImage(named: "chilly_icon")
        case 0...10 :
            imageView.image = UIImage(named: "warm_icon")
        case 10...20 :
            imageView.image = UIImage(named: "hot_icon")
        case 20... :
            imageView.image = UIImage(named: "veryHot_icon")
        default: break
        }
    }
    
    // Загрузку в переменную делали до этой функции чтобы эта функция
    // Могл из переменной достать город когда мы его уже туда положим,
    //если положим после этой функции то в переменной будет пусто и в лейб ничего не выведется
    func setDefaultView() {
        imageView.image = UIImage(named: "empty_icon")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
     
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainScreenViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SellID", for: indexPath) as? ForecastCell
        let forecastDay = forecastDays[indexPath.row]
        let tittle = presenter.dayOfWeek(from: forecastDay.date, with: "yyyy-MM-dd")
        cell?.configur(tittle: tittle ?? "", subtittle: "\(forecastDay.day.averageTemperatureInCelsius)")
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
