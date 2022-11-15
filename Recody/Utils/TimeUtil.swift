//
//  TimeUtil.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/14.
//

import Foundation

class TimeUtil {
//    // 1. current month (yaer, month, day)
//    static func nowDateComponents() -> DateComponents {
//        return Calendar.current.dateComponents([.year,.month,.day,.weekday,.weekOfMonth], from: Date())
//    }
//    // 2. 첫주 시작 요일
//    func month(){
//        let year = 2022
//        let month = 10
//        let calendar = Calendar(identifier: .gregorian)
//        calendar.dateComponents([.year,.month,.weekday], from: DateComponents(calendar: calendar,year: year,month: month).date!)
//    }
    // 필요한 정보
    // 1. 첫주 시작 요일 [ 일,월,화,수,목.금,토 ]
    // 일 = 1 / 토 = 7
    static func startWeekDayCount( _ year: Int, _ month: Int) -> Int {
        if month > 0 && month < 13 {
            let calendar = Calendar(identifier: .gregorian)
            let targetDate = Calendar.current.dateComponents([.weekday], from: DateComponents(calendar: calendar, year: year, month: month).date!)
            return targetDate.weekday!
        } else {
          fatalError("month out of bounds")
        }
    }
    // 2. 주의 수
    static func weekCountOfMonth( _ year: Int, _ month: Int) {
    }
    // 3. 마지막 일
    static func lastDayCount( _ year: Int, _ month: Int) {
//        if month > 12 || month < 1 { fatalError("month out of bounds") }
//        let calendar = Calendar(identifier: .gregorian)
//        let nextMonthInt = month == 12 ? 1 : month + 1
//        let nextMonth = DateComponents(calendar: calendar,year:  nextMonthInt == 1 ? year + 1 : year ,month: nextMonthInt).date
//        let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth!)
//        let date
    }
    // 기능 합수
    // 1. 달 인자를 받아 해당 캘린더 정보를 뽑음
}
