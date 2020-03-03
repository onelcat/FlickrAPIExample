//
//  Date_Extesion.swift
//  FlickrAPIExample
//
//  Created by haoshuai on 2020/3/3.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import Foundation

extension Date {
    func dateFormat(formatter: String?) -> String {
        if let format = formatter {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = format
            let date_str = dateFormatter.string(from: self)
            return date_str
        }
        return ""
    }
}

extension NSDate {
    
}
