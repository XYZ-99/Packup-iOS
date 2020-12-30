//
//  CourseInfoJSON.swift
//  Packup
//
//  Created by Yinzhen Xu on 2020/12/30.
//

import Foundation

struct CourseInfoJSON: Codable {
    let success: Bool
    let course: [CoursesAtTimeNum]
    let remark: String
}

struct CoursesAtTimeNum: Codable {
    let fri, mon, sat, sun, thu: CourseInWeekdayAtTimeNum
    let timeNum: String
    let tue, wed: CourseInWeekdayAtTimeNum
}

struct CourseInWeekdayAtTimeNum: Codable {
    let courseName: String
    let parity: String
    let sty: Sty
}

enum Sty: String, Codable {
    case backgroundColorAquamarine = "background-color: aquamarine"
    case backgroundColorLightblue = "background-color: lightblue"
    case backgroundColorLightcoral = "background-color: lightcoral"
    case backgroundColorLightcyan = "background-color: lightcyan"
    case backgroundColorLightgreen = "background-color: lightgreen"
    case backgroundColorLightgrey = "background-color: lightgrey"
    case backgroundColorLightsalmon = "background-color: lightsalmon"
    case empty = ""
}

// MARK: Convenience initializers

extension CourseInfoJSON {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(CourseInfoJSON.self, from: data) else { return nil }
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

extension CoursesAtTimeNum {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(CoursesAtTimeNum.self, from: data) else { return nil }
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

extension CourseInWeekdayAtTimeNum {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(CourseInWeekdayAtTimeNum.self, from: data) else { return nil }
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
