//
//  WeatherWebService.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import Foundation

struct WeatherResource<T> {
    let url:URL
    let parse:(Data) -> T?
}

final class WeatherWebService {
    func load<T>(resource:WeatherResource<T>,completion:@escaping (T?)-> ()) {
        URLSession.shared.dataTask(with: resource.url) { data, URLResponse, error in
            
            if let data = data {
                //URLSession이 백그라운드에서 실행되므로 메인쓰레드로 데이터를 보내줘야함.
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            }else {
                completion(nil)
            }
        }.resume()
    }
}
