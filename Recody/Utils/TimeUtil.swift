//
//  TimeUtil.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/14.
//

import Foundation

class TimeUtil {
    // 오늘 연 월 일 날짜를 제공
    static func nowDateComponent() ->  DateComponents {
        let date = Calendar.current.dateComponents([.year,.month,.day], from: Date())
        return date
    }
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
    //첫주에 몇칸 차지하는지 (일-토 기준) / (1 일경우 토요일만 차지)
    static func firstWeekDaysCount( _ year: Int, _ month: Int) -> Int {
        let firstWeekDaysCount = 8 - TimeUtil.startWeekDayCount(year, month)
        return firstWeekDaysCount
    }
    //마지막주에 몇칸 차지하는지 (일-토 기준) / (1 일경우 일요일만 차지)
    static func lastWeekDayCount( _ year: Int, _ month: Int) -> Int {
        let startWeekDayCount = TimeUtil.startWeekDayCount(year, month) //첫주의 시작일 7
        var lastDayCount = TimeUtil.lastDayCount(year, month) // 총일수 31
        let firstWeekDaysCount = 8 - startWeekDayCount // 첫주에 몇칸을 차지하시는지
        let lastWeekDaysCount = (lastDayCount - firstWeekDaysCount) % 7 // 2
        return lastWeekDaysCount == 0 ? 7 : lastWeekDaysCount // lastWeekDaysCount 가 0 일경우 7칸을 차지하는거임
    }
    // 2. 주의 수 -> 검증완료
    static func weekCountOfMonth( _ year: Int, _ month: Int) -> Int {
        if month > 0 && month < 13 {
            let startWeekDayCount = TimeUtil.startWeekDayCount(year, month) //첫주의 시작일 7
            var lastDayCount = TimeUtil.lastDayCount(year, month) // 총일수 31
            let firstWeekDaysCount = 8 - startWeekDayCount // 첫주에 몇칸을 차지하시는지
            var lastWeekDaysCount = (lastDayCount - firstWeekDaysCount) % 7 // 2
            var weekCount = 1
            if lastWeekDaysCount > 0 {
                weekCount += (lastDayCount - (firstWeekDaysCount + lastWeekDaysCount))/7
                weekCount += 1
            }else if (lastWeekDaysCount == 0 ) {
                weekCount += (lastDayCount - (firstWeekDaysCount))/7
            }else {
                weekCount += (lastDayCount - (firstWeekDaysCount))/7
            }
            
            return weekCount
        }else {
            fatalError("month out of bounds")
        }
    }
    // 3. 마지막 일
    static func lastDayCount( _ year: Int, _ month: Int) -> Int{
        if month > 0 && month < 13 {
            let dayCounts = [ -1 ,31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
            if checkLeapYear(year) {
                if month == 2 {
                    return dayCounts[month] + 1
                }
            }
            return dayCounts[month]
        } else {
            fatalError("month out of bounds")
        }
    }
    // 윤년 검사로직 -> 검증완료
    static func checkLeapYear(_ year:Int) -> Bool{
        var isLeapYear = true
        if year % 4 != 0 {
            isLeapYear = false
        }
        if isLeapYear && year % 100 == 0 {
            isLeapYear = false
        }
        if !isLeapYear && year % 400 == 0 {
            isLeapYear = true
        }
        return isLeapYear
    }
}
