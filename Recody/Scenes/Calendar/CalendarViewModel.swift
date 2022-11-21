//
//  CalendarViewModel.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/17.
//

import Foundation

class CalendarViewModel {
    var selectYear = 0
    // 선택된 년도
    var selectMonth = 0
    // 선택된 달
    var weeks = [[Int]]()
    var startWeekDay = 0
    // 첫날이 무슨요일인지
    var lastDayCount = 0
    // 기본값 30 / 연 월이 선택되고 결정됨
    var weekCount = 0
    // 주의 수
    var recordImgs = [Int:String]()
    // key 날의수
    // value 해당 날짜에 가장 최근에 기록한 작품의 포스터 이미지 url 값
    var isStartSunday = true
    // 첫주가 일요일로 시작 = true
    // 첫주가 월요일로 시작 = false
    var lastWeekDayCount = 0
    // 마지막 주 일수
    init() {
        let component = TimeUtil.nowDateComponent()
        self.selectYear = component.year!
        self.selectMonth = component.month!
        updateState()
    }
    func nextMonth(){
        if self.selectMonth == 12 {
            self.selectMonth = 1
            self.selectYear += 1
        }else {
            self.selectMonth += 1
        }
        updateState()
    }
    func previousMonth() {
        if self.selectMonth == 1 {
            self.selectMonth = 12
            self.selectYear -= 1
        } else {
            self.selectMonth -= 1
        }
        updateState()
    }
    func updateState() {
        self.lastDayCount = TimeUtil.lastDayCount(selectYear, selectMonth)
        self.startWeekDay = TimeUtil.startWeekDayCount(selectYear, selectMonth)
        self.weekCount = TimeUtil.weekCountOfMonth(selectYear, selectMonth)
        self.lastWeekDayCount = TimeUtil.lastWeekDayCount(selectYear, selectMonth)
        weeks.removeAll()
        weeks =  (1...self.weekCount).map({ _ -> [Int] in
            return [-1, -1, -1, -1, -1, -1, -1]
        })
        var firstWeekDayCount = 1
        
        for index in 0...6 {
            if index+1 >= startWeekDay {
                weeks[0][index] = firstWeekDayCount
                firstWeekDayCount += 1
            }
        }
        let firstWeekIndex = 0
        let lastWeekIndex = weeks.count-1
        for week in firstWeekIndex+1...lastWeekIndex {
            if week == lastWeekIndex {
                for index in 0...6 {
                    if (index+1) <= lastWeekDayCount {
                        weeks[week][index] = (week-1)*7 + (index ) + firstWeekDayCount
                    }
                }
            } else {
                for index in 0...6 {
                    weeks[week][index] = (week-1)*7 + (index ) + firstWeekDayCount
                }
            }
        }
    }
}
