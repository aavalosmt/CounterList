//
//  LocalizationManager.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 1/31/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import Foundation
import UIKit

class LocalizationManager {
    struct Constants {
        static let defaultTable = "Default"
    }
    
    static let shared = LocalizationManager()
    
    // Variables and constants
    
    var isLocalizationEnabled: Bool = true
    
    private init() {

    }
    
    /**
     * Get the first preferred device Language, if it's not supported returns
     * the defaultLanguage
     */
    func getLocale() -> String {
        if let lang = Locale.preferredLanguages.first {
            let _lang = lang[..<lang.index(lang.startIndex, offsetBy: 2)]
            if AppConstants.Language.supported.contains(String(_lang)) {
                return String(_lang)
            }
        }
        return AppConstants.Language.defaultLanguage
    }
    
    /**
     * If the device has more than one preferred Language,
     * and the first one is not supported, instead of returning defaultLanguage,
     * looks if the other preffered languages are supported to return one of them.
     * If not, return defaultLanguage
     */
    func getPreferredLocale() -> String {
        let preferredLanguageArray = Locale.preferredLanguages
        for language in preferredLanguageArray {
            let lang = language[..<language.index(language.startIndex, offsetBy: 2)]
            if AppConstants.Language.supported.contains(String(lang)) {
                return String(lang)
            }
        }
        return AppConstants.Language.defaultLanguage
        
    }
    
    /** Get the first preferred device Language */
    func getRawLocale() -> String? {
        let locale = Locale.preferredLanguages.first ?? ""
        return String(locale[..<locale.index(locale.startIndex, offsetBy: 2)])
    }
    
    /** Get the preferred device Languages */
    func getPreferredLanguages() -> [String] {
        return Locale.preferredLanguages
    }
    
    /** Get the array of supported Languages */
    func getSupported() -> [String] {
        return AppConstants.Language.supported
    }
    
    /** Return true if the locale is supported */
    func isActualLanguageSupported() -> Bool {
        if let lang = Locale.preferredLanguages.first {
            let _lang = lang[..<lang.index(lang.startIndex, offsetBy: 2)]
            return AppConstants.Language.supported.contains(String(_lang))
        } else {
            return false
        }
    }
    
    /** Return true if language is supported by the app */
    func isSupported(language: String) -> Bool {
        let lang = language[..<language.index(language.startIndex, offsetBy: 2)]
        let locale = AppConstants.Language.supported
        return locale.contains(String(lang))
    }
    
    // MARK: - Localize methods
    
    /**
     * Search the key in the localization tables
     *
     * - returns
     * The localized string for the received key, if the key is not found
     * it'll return the key.
     */
    subscript(key: String) -> String {
        get {
            return self.localize(key)
        }
    }
    
    /**
     * Search the key in the localization tables
     *
     * - returns
     * The localized string for the received key, if the key is not found
     * it'll return the key.
     *
     * - parameters:
     *     - key: The key of the string that sould be localizated
     */
    func localize(_ key: String) -> String {
        guard let fallbackPath = Bundle.main.path(forResource: AppConstants.Language.defaultLanguage, ofType: AppConstants.Extension.LPROJExtension) else { return key }
        guard let fallbackBundle = Bundle(path: fallbackPath) else { return key }
        
        if isLocalizationEnabled && isActualLanguageSupported() {
            return self.findTable(for: key)
        }
        return self.findTable(for: key, bundle: fallbackBundle)
    }
   
}

private extension LocalizationManager {
    /**
     * Get the localized string, first will search the key in Default.strings table and
     * if the key is not found, it will search in Localized.string table.
     *
     * - returns
     * The localized string for the received key, if the key is not found
     * it'll return the key.
     *
     * - parameters:
     *     - key: The key of the string that sould be localizated
     *     - bundle: (Optional, default: Bundle.main) The bundle that has the tables.
     */
    func findTable(for key: String, bundle: Bundle = Bundle.main) -> String {
        let localized = bundle.localizedString(forKey: key, value: nil, table: Constants.defaultTable)
        
        if localized == key || localized.isEmpty {
            return bundle.localizedString(forKey: key, value: nil, table: nil)
        }
        
        return localized
    }
}
