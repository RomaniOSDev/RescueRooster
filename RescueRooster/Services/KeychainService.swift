//
//  KeychainService.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import Foundation
import Security

// MARK: - Keychain Service
class KeychainService {
    static let shared = KeychainService()
    
    private init() {}
    
    // MARK: - Constants
    private let service = "RescueRooster"
    private let apiKeyAccount = "NewsAPIKey"
    
    // MARK: - Public Methods
    
    /// Save API key to Keychain
    func saveAPIKey(_ apiKey: String) -> Bool {
        guard let data = apiKey.data(using: .utf8) else {
            print("❌ Failed to convert API key to data")
            return false
        }
        
        // Delete existing key if it exists
        deleteAPIKey()
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: apiKeyAccount,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("✅ API key saved to Keychain successfully")
            return true
        } else {
            print("❌ Failed to save API key to Keychain. Status: \(status)")
            return false
        }
    }
    
    /// Get API key from Keychain
    func getAPIKey() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: apiKeyAccount,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess,
           let data = result as? Data,
           let apiKey = String(data: data, encoding: .utf8) {
            print("✅ API key retrieved from Keychain successfully")
            return apiKey
        } else {
            print("❌ Failed to retrieve API key from Keychain. Status: \(status)")
            return nil
        }
    }
    
    /// Delete API key from Keychain
    func deleteAPIKey() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: apiKeyAccount
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess || status == errSecItemNotFound {
            print("✅ API key deleted from Keychain successfully")
            return true
        } else {
            print("❌ Failed to delete API key from Keychain. Status: \(status)")
            return false
        }
    }
    
    /// Check if API key exists in Keychain
    func hasAPIKey() -> Bool {
        return getAPIKey() != nil
    }
    
    /// Initialize API key (called on first launch)
    func initializeAPIKey() {
        if !hasAPIKey() {
            let defaultAPIKey = "3f44742c4abc42d9a6401da6a4335aa8"
            saveAPIKey(defaultAPIKey)
        }
    }
}
