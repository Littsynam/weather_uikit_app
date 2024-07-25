//
//  WeatherService.swift
//  weatherApp
//
//  Created by Mastery on 08.07.2024.
//

import Foundation





class WeatherService {
    private let apiKey = "cb8e7167d87249eb9f0163618240304"
    private let baseUrl = "https://api.weatherapi.com/v1"
    
    func fetchCurrentWeather(city:String, complition: @escaping (Response)-> Void) {
        
        let urlString = baseUrl + "/current.json" + "?" + "key=\(apiKey)" + "&" + "q=\(city)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            let decoder = JSONDecoder()
            
            guard let data else {
                return
            }
            
            do {
                let weatherResponce = try decoder.decode(Response.self, from: data)
                complition(weatherResponce)
            } catch (let error){
                print(error)
                print("Хуевая ошибка")
            }
        }
        )
        task.resume()
    }
    
    func fetchForecastWeather(city:String, complition: @escaping (Forecast)-> Void) {
        
        let urlString = baseUrl + "/forecast.json" + "?" + "key=\(apiKey)" + "&" + "q=\(city)" + "&" + "days=5"
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            let decoder = JSONDecoder()
            
            guard let data else {
                return
            }
            
            do {
                let weatherResponce = try decoder.decode(Response2.self, from: data)
                if let forecast = weatherResponce.forecast {
                    complition(forecast)
                }
            } catch (let error){
                print(error)
                print("Хуевая ошибка2")
            }
        }
        )
        task.resume()
    }
}

