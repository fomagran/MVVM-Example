//
//  String + Extensions.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import Foundation

extension String {
    //URL변환
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
