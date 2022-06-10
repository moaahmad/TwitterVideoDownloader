//
//  DateFormatHelper.swift
//
//  Created on 19/04/2019.

import Foundation

enum DateConversionError: Error {
    case failedConvertingFromString(_ string: String)
}

enum DateFormat {
    case dateTime
    case ddMMyy
    case MMyyyy
    case ddMMMyyyy
    case ddMMMyyyyHHMM
    case HHmm
    case ddMMM
    case custom(String)
    
    func toString() -> String {
        switch self {
        case .dateTime: return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .ddMMMyyyyHHMM: return "dd.MM.yyyy HH:mm:ss"
        case .ddMMyy: return "dd/MM/yy"
        case .ddMMMyyyy: return "dd MMM yyyy"
        case .MMyyyy: return "MM yyyy"
        case .HHmm: return "HH:mm"
        case .ddMMM: return "dd MMM"
        case .custom(let format): return format
        }
    }
}

class DateConverter {

    private let dateFormatter = DateFormatter()
    private static let `default` = DateConverter()
    
    static func toDate(dateString: String, format: DateFormat) -> Date? {
        let converter = DateConverter.default
        converter.dateFormatter.timeZone = TimeZone.current
        converter.dateFormatter.dateFormat = format.toString()
        guard let date = converter.dateFormatter.date(from: dateString) else {
            return nil
        }
        return date
    }
    
    static func toString(date: Date, format: DateFormat) -> String {
        let converter = DateConverter.default
        converter.dateFormatter.timeZone = TimeZone.current
        converter.dateFormatter.dateFormat = format.toString()
        return converter.dateFormatter.string(from: date)
    }
}


