//
//  WeatherResponse.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import Foundation

struct WeatherResponse:Codable {
    //날씨 데이터 json에서 main안에 날씨 정보가 들어있음
    let main:Weather
}

struct Weather:Codable {
    let temp:Double
    let humidity:Double
}
