//
//  UserPresfHelper.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let kUpdateGoingEvent = NSNotification.Name("kUpdateGoingEvent")
    static let kUpdateWentEvent = NSNotification.Name("kUpdateWentEvent")
    static let kLogin = NSNotification.Name("kLogin")
    static let kLogout = NSNotification.Name("kLogout")
}

struct PrefsKey {
    static let keyUpdateNews = "keyUpdateNews"
    static let keyUpdatePopular = "keyUpdatePopular"
    static let userToken = "token"
    static let isLoggined = "isLogined"
    static let isEventUpdated = "isEventUpdated"
    static let isCallMyEventAPI = "isCallMyEventAPI"
    
}

class UserPrefsHelper: NSObject {
    static let shared: UserPrefsHelper = UserPrefsHelper()
    
    private override init() {}
    
    // MARK: - update DB
    
    func setIsEventUpdated(_ updated: Bool) {
        UserDefaults.standard.set(updated, forKey: PrefsKey.isEventUpdated)
    }
    func getIsEventUpdated() -> Bool {
        return UserDefaults.standard.bool(forKey: PrefsKey.isEventUpdated)
    }
    
    func setkeyUpdateNews(_ timeUpdate: Int) {
        UserDefaults.standard.set(timeUpdate, forKey: PrefsKey.keyUpdateNews)
    }
    
    func getKeyUpdateNews() -> Int {
        return UserDefaults.standard.integer(forKey: PrefsKey.keyUpdateNews)
    }
    
    func setKeyUpdatePopular(_ timeUpdate: Int) {
        UserDefaults.standard.set(timeUpdate, forKey: PrefsKey.keyUpdatePopular)
    }
    
    func getKeyUpdatePopular() -> Int {
        return UserDefaults.standard.integer(forKey: PrefsKey.keyUpdatePopular)
    }
    
    // MARK: - user
    
    func setIsloggined(_ check: Bool) {
        UserDefaults.standard.set(check, forKey: PrefsKey.isLoggined)
    }
    func getIsLoggined() -> Bool {
        return UserDefaults.standard.bool(forKey: PrefsKey.isLoggined) ?? false
    }
    
    func setUserToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: PrefsKey.userToken)
    }
    
    func getUserToken() -> String {
        return UserDefaults.standard.string(forKey: PrefsKey.userToken) ?? ""
    }
    
    func setIsCallMyEventAPI(_ check: Bool) {
        UserDefaults.standard.set(check, forKey: PrefsKey.isCallMyEventAPI)
    }
    
    func getIsCallMyEventAPI() -> Bool {
        return UserDefaults.standard.bool(forKey: PrefsKey.isCallMyEventAPI) ?? false
    }
    
    
}
