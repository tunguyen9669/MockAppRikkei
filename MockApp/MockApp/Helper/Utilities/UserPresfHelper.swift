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
    static let isCallMyEventGoingAPI = "isCallMyEventGoingAPI"
    static let isCallMyEventWentAPI = "isCallMyEventWentAPI"
    static let email = "email"
    static let password = "password"
    static let timeLogin = "timeLogin"
    
}

class UserPrefsHelper: NSObject {
    static let shared: UserPrefsHelper = UserPrefsHelper()
    
    private override init() {}
    
    // MARK: - update DB
    // HaND: Sử dụng biến với get set
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
    
    func setIsCallMyEventGoingAPI(_ check: Bool) {
        UserDefaults.standard.set(check, forKey: PrefsKey.isCallMyEventGoingAPI)
    }
    
    func getIsCallMyEventGoingAPI() -> Bool {
        return UserDefaults.standard.bool(forKey: PrefsKey.isCallMyEventGoingAPI) ?? false
    }
    
    func setIsCallMyEventWentAPI(_ check: Bool) {
        UserDefaults.standard.set(check, forKey: PrefsKey.isCallMyEventWentAPI)
    }
    
    func getIsCallMyEventWentAPI() -> Bool {
        return UserDefaults.standard.bool(forKey: PrefsKey.isCallMyEventWentAPI) ?? false
    }
    
    func setEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: PrefsKey.email)
    }
    
    func getEmail() -> String {
        return UserDefaults.standard.string(forKey: PrefsKey.email) ?? ""
    }
    
    func setPassword(_ email: String) {
        UserDefaults.standard.set(email, forKey: PrefsKey.password)
    }
    
    func getPassword() -> String {
        return UserDefaults.standard.string(forKey: PrefsKey.password) ?? ""
    }
    
    func setTimeLogin(_ time: Int) {
        UserDefaults.standard.set(time, forKey: PrefsKey.timeLogin)
    }
    
    func getTimeLogin() -> Int {
        return UserDefaults.standard.integer(forKey: PrefsKey.timeLogin)
    }
    
}
