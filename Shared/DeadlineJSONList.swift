//
//  DeadlineJSON.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/7.
//

import Foundation

typealias DeadlineJSONList = [DeadlineJSON]

struct DeadlineJSON: Codable {
    let gradable, allDay: Bool
    let itemSourceType, itemSourceID: String
    let userCreated, purpleRepeat: Bool
    let calendarID: String
    let recur: Bool
    let color, calendarName: String
    let editable, isUltraEvent: Bool
    let calendarNameLocalizable: CalendarNameLocalizable
    let disableResizing, attemptable, isDateRangeLimited: Bool
    let id, start, end: String
    let location: JSONNull?
    let title, startDate, endDate, eventType: String

    enum CodingKeys: String, CodingKey {
        case gradable, allDay, itemSourceType
        case itemSourceID = "itemSourceId"
        case userCreated
        case purpleRepeat = "repeat"
        case calendarID = "calendarId"
        case recur, color, calendarName, editable, isUltraEvent, calendarNameLocalizable, disableResizing, attemptable, isDateRangeLimited, id, start, end, location, title, startDate, endDate, eventType
    }
}

struct CalendarNameLocalizable: Codable {
    let rawValue: String
}

// MARK: Convenience initializers

extension DeadlineJSON {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(DeadlineJSON.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension CalendarNameLocalizable {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(CalendarNameLocalizable.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Array where Element == DeadlineJSONList.Element {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(DeadlineJSONList.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


