//
//  RecodyTests.swift
//  RecodyTests
//
//  Created by Glory Kim on 2022/12/06.
//

import XCTest
@testable import Recody
// Api Test 하는 방법
// 함수 네이밍 testApi + 테스트 하려는 ApiCommand의 함수이름
// testApiLogin의 코드를 복사 하여 새로만든후
// ApiCommand만 변경후 파라미터를 넣는다
// Mac 키보드기준 command + 6 을 누른후
// 타겟을 Recody -> RecodyTests 로 변경한다.
// 실행 후 테스트 통과를 못한 코드를 수정한다.
final class RecodyTests: XCTestCase {

    func testApiLogin() {
        let command = ApiCommand.login("ikmujn5@naver.com", "asdb")
        testApi(command: command)
    }
    func testApiCheckValidEmail() {
        let command = ApiCommand.checkValidEmail("ikmujn5@naver.com")
        testApi(command: command)
        XCTAssertFalse(false)
    }
    func testApiResetPasswordToEmail(){
        let command = ApiCommand.resetPasswordToEmail("ikmujn5@naver.com")
        testApi(command: command)
    }
//    func tes
    
    
    private func testApi(command : ApiCommand){
        let expectation = expectation(description: "url : \(ApiClient.server + command.subDomain)")
        ApiClient.request(command: command, { data in
            if let dic = data.obj {
                print("== dic ==")
                print(dic)
                print("== dic end ==")
                XCTAssertTrue(true)
            }
            expectation.fulfill()
        }, { eMsg in
            XCTAssertFalse(false)
        })
        waitForExpectations(timeout: 0.5){ error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
