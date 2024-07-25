//
import Foundation

protocol MainScreenPresenterOutput {
    func onLoadTemperature(temperature: Response)
    func onLoadForecast(forecast: Forecast)
}

class MainScreenPresenter {
    
    private let dateFormatter = DateFormatter()
    private let service = WeatherService()
    
    var delegate: MainScreenPresenterOutput?
     
    func searchInfo(by city: String) {
        getTemperature(by: city)
        getForecast(by: city)
    }
    
    private func getTemperature(by city:String){
        service.fetchCurrentWeather(city: city, complition: { [weak self] response in
            DispatchQueue.main.async {
                self?.delegate?.onLoadTemperature(temperature: response)
            }
        })
    }
    
    private func getForecast(by city:String){
        service.fetchForecastWeather(city: city, complition: { [weak self] forecast in
            DispatchQueue.main.async {
                self?.delegate?.onLoadForecast(forecast: forecast)
            }
        })
    }
    
    func dayOfWeek(from dateString: String, with dateFormat: String) -> String? {
        // Форматтер для преобразования строки в дату
        
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "ru_RU") // Устанавливаем локаль на русский язык (если нужно)
        
        // Преобразование строки в дату
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        // Форматтер для получения дня недели
        
        dateFormatter.dateFormat = "EEEE" // "EEEE" дает полный день недели
        dateFormatter.locale = Locale(identifier: "ru_RU") // Устанавливаем локаль на русский язык (если нужно)
        
        // Преобразование даты в день недели
        return dateFormatter.string(from: date)
    }
}
