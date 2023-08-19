//
//  UserDefautlsManager.swift
//  Recody
//
//  Created by 마경미 on 23.07.23.
//

import Foundation

enum UserDefautlsKeys: String {
    case homeImage = "homeImage"
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    
    // 데이터를 UserDefaults에 저장하는 메서드
    func saveData(key: UserDefautlsKeys, _ data: Any) {
        userDefaults.set(data, forKey: key.rawValue)
    }
    
    // UserDefaults에서 데이터를 불러오는 메서드
    func loadData(key: UserDefautlsKeys) -> Any? {
        return userDefaults.value(forKey: key.rawValue)
    }
    
    // 저장된 데이터를 삭제하는 메서드
    func clearData(key: UserDefautlsKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}

