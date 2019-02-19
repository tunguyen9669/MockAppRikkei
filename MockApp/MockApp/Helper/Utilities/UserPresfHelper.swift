//
//  UserPresfHelper.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

struct PrefsKey {
    static let keyUpdateNews = "keyUpdateNews"
    static let keyUpdatePopular = "keyUpdatePopular"
    static let userToken = "token"
    
}

class UserPrefsHelper: NSObject {
    static let shared: UserPrefsHelper = UserPrefsHelper()
    
    private override init() {}
    
    // MARK: - update DB
    
    func setkeyUpdateNews(_ timeUpdate: Int) {
        UserDefaults.standard.set(timeUpdate, forKey: PrefsKey.keyUpdateNews)
    }
    
    func getKeyUpdateNews() -> Int {
        return UserDefaults.standard.integer(forKey: PrefsKey.keyUpdateNews) ?? 0
    }
    
    func setKeyUpdatePopular(_ timeUpdate: Int) {
        UserDefaults.standard.set(timeUpdate, forKey: PrefsKey.keyUpdatePopular)
    }
    
    func getKeyUpdatePopular() -> Int {
        return UserDefaults.standard.integer(forKey: PrefsKey.keyUpdatePopular)
    }
    
    // MARK: - user token
    
    func setUserToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: PrefsKey.userToken)
    }
    
    func getUserToken() -> String {
        return UserDefaults.standard.string(forKey: PrefsKey.userToken) ?? ""
    }
    
    
}
