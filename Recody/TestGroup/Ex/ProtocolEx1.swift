////
////  ProtocolEx1.swift
////  Recody
////
////  Created by Glory Kim on 2022/10/20.
////
//// @Link - https://docs.swift.org/swift-book/LanguageGuide/Protocols.html
//import Foundation
////MARK: - Protocol
//
////MARK: - Value Type
////EX1
//protocol P1 {
//    var name : String { get }
//    var nick_name : String { get set }
//}
//struct TestStruct : P1 {
//    var name : String = "Young"
//    var nick_name: String = "nick" // 변경가능
//}
////func A(){
////    var a = TestStruct()
////    a.nick_name = "john"
////    print(a.nick_name) // "john"
////}
//
////Ex1 -1
//struct TestStruct2 : P1 {
//    var name : String
//    var nick_name: String
//}
////func B(){
////    _ = TestStruct2(name: "Young", nick_name: "nick")
////}
//
//protocol P1E {
//    var name : String { get }
//}
////MARK: - Enum 에서도 특정 속성을 강제할수있다.
//enum P1Enum : P1E {
//    case A
//    case B
//    var name: String {
//        switch self {
//        case .A:
//            return "A"
//        case .B:
//            return "B"
//        }
//    }
//}
//
