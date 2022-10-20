//
//  ProtocolEx2.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/20.
//

//MARK: - 함수 타입
import Foundation
// 필수 구현함수 강제
protocol P2 {
    func sum(i1:Int,i2:Int) -> Int
    func sum2(i1:Int,i2:Int) -> Int
}
//extension 을 통해 미리 구현해놓을수도있음
extension P2 {
    func sum2(i1:Int,i2:Int) -> Int {
        return i1 + i2
    }
}
class P2A : P2 {
    func sum(i1: Int, i2: Int) -> Int {
        return i1 + i2
    }
}
