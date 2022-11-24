//
//  MyPageViewModel.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/23.
//

import Foundation

class MyPageViewModel {
    var nickName = "영화가젤좋아" // 닉네임
    var totalRecordCount = 999 // 총 기록
    var profileImageUrl = "" // 프로필 이미지 url
    var thisMonthAppreciationWorksCount = 99 // 이달에 감상 작품수
    var monthNickName = "영화 매니아" // 이 달의 별명 -> 영화 매니아
    var mostAppreciationGenreName = "영화" // 가장 많이본 작품명
    var mostAppreciationGenrePer = 56 // 가장 많이본 작품의 총비율
    var recordedWorks = [Work]() // 기록 중인 작품
    var dibsOnWorks = [Work]() // 찜한 작품
    var alarmCount = 0 // 알림 수
    var month = 0 // 월
    var year = 0 // 연
    var maxPageCount = 2
    var bottomPageIndex = 0 // 하단 기록 중인 작품 & 찜한 작품 페이징
    func nextPage(){
        if bottomPageIndex < maxPageCount-1 {
            bottomPageIndex += 1
        }
    }
//   on #51453D // off #CECECE
    
    func previousPage(){
        if bottomPageIndex > 0  {
            bottomPageIndex -= 1
        }
    }
}
