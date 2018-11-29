//
//  Holidays.swift
//  AddressBookApp
//
//  Created by oingbong on 29/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct Holidays {
    var keyDate = "date"
    var keySubtitle = "subtitle"
    var holidays = [Holiday]()
    
    var count: Int {
        return holidays.count
    }
    
    mutating func convertAndPush(from json: String) {
        guard let elements = convertDictionary(from: json) else { return }
        let data = convertHoliday(from: elements)
        push(from: data)
    }
    
    private func convertDictionary(from json: String) -> [[String: String]]? {
        guard let jsonData = json.data(using: .utf8) else { return nil }
        do {
            let result = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: String]]
            return result
        } catch {
            return nil
        }
    }
    
    private func convertHoliday(from elements: [[String: String]]) -> [Holiday] {
        var result = [Holiday]()
        for element in elements {
            guard let date = element[keyDate] else { continue }
            guard let subtitle = element[keySubtitle] else { continue }
            let holiday = Holiday(date: date, subtitle: subtitle)
            result.append(holiday)
        }
        return result
    }
    
    mutating private func push(from elements: [Holiday]) {
        for element in elements {
            holidays.append(element)
        }
    }
    
    subscript(index: Int) -> Holiday {
        return holidays[index]
    }
}