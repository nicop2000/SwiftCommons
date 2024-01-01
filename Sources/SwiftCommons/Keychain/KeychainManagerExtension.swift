//
//  KeychainManagerExtension.swift
//
//
//  Created by Nico Petersen on 09.09.23.
//

import Foundation

public extension KeychainManager {
    enum ItemType: RawRepresentable {
        public typealias RawValue = CFString

        case generic
        case certificate
        case password
        case identity
        case cryptography

        public var rawValue: CFString {
            switch self {
            case .generic:
                return kSecClassGenericPassword
            case .certificate:
                return kSecClassCertificate
            case .password:
                return kSecClassInternetPassword
            case .identity:
                return kSecClassIdentity
            case .cryptography:
                return kSecClassKey
            }
        }

        public init?(rawValue: CFString) {
            switch rawValue {
            case kSecClassGenericPassword:
                self = .generic
            case kSecClassCertificate:
                self = .certificate
            case kSecClassInternetPassword:
                self = .password
            case kSecClassIdentity:
                self = .identity
            case kSecClassKey:
                self = .cryptography
            default:
                return nil
            }
        }
    }

    enum KeychainError: Error, Equatable {
        case invalidData
        case itemNotFound
        case duplicateItem
        case incorrectAttributeForClass
        case noSuchKeychain
        case unexpected(OSStatus)

        var localizedDescription: String {
            switch self {
            case .invalidData:
                return "Invalid data"
            case .itemNotFound:
                return "Item not found"
            case .duplicateItem:
                return "Duplicate Item"
            case .incorrectAttributeForClass:
                return "Incorrect Attribute for Class"
            case .noSuchKeychain:
                return "No such keychain"
            case .unexpected(let oSStatus):
                return "Unexpected error - \(oSStatus)"
            }
        }
    }

    internal func convertError(_ error: OSStatus) -> KeychainError {
        switch error {
        case errSecItemNotFound:
            return .itemNotFound
        case errSecDataTooLarge:
            return .invalidData
        case errSecDuplicateItem:
            return .duplicateItem
        case errSecNoSuchKeychain:
            return .noSuchKeychain
        default:
            return .unexpected(error)
        }
    }
    
    enum KeychainItemAccessLevel: RawRepresentable {
        /// After a restart the phone must be unlocked once to access the data. Afterwards it stays available till the next restart
        /// Included in encrypted backups
        case afterFirstUnlock

        /// After a restart the phone must be unlocked once to access the data. Afterwards it stays available till the next restart
        /// NOT included in encrypted backups
        case afterFirstUnlockThisDeviceOnly

        /// The data is accessable while the phone is unlocked. This is the default behaviour for a keychain item
        /// Included in encrypted backups
        case whenUnlocked
        
        /// The data is accessable while the phone is unlocked. This is the default behaviour for a keychain item
        /// NOT included in encrypted backups
        case whenUnlockedThisDeviceOnly
        
        /// The data is only available when the devicde is unlocked. A passcode must be set to use this option. Upon deleting the passcode the data will be deleted as well.
        /// NOT included in backups
        case whenPasscodeSetThisDeviceOnly
        
        public var rawValue: CFString {
            switch self {
            case .afterFirstUnlock:
                return kSecAttrAccessibleAfterFirstUnlock
            case .afterFirstUnlockThisDeviceOnly:
                return kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            case .whenPasscodeSetThisDeviceOnly:
                return kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
            case .whenUnlocked:
                return kSecAttrAccessibleWhenUnlocked
            case .whenUnlockedThisDeviceOnly:
                return kSecAttrAccessibleWhenUnlockedThisDeviceOnly
            }
        }

        public init?(rawValue: CFString) {
            switch rawValue {
            case kSecAttrAccessibleAfterFirstUnlock:
                self = .afterFirstUnlock
            case kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly:
                self = .afterFirstUnlockThisDeviceOnly
            case kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly:
                self = .whenPasscodeSetThisDeviceOnly
            case kSecAttrAccessibleWhenUnlocked:
                self = .whenUnlocked
            case kSecAttrAccessibleWhenUnlockedThisDeviceOnly:
                self = .whenUnlockedThisDeviceOnly
            default:
                return nil
            }
        }
    }
}
