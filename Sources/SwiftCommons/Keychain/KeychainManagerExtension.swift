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

    enum KeychainError: Error {
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
        /**
          The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
         
          After the first unlock, the data remains accessible until the next restart. This is recommended for items that need to be accessed by background applications. Items with this attribute migrate to a new device when using encrypted backups.
         */
        
        case afterFirstUnlock
        
        /**
         The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
         
         After the first unlock, the data remains accessible until the next restart. This is recommended for items that need to be accessed by background applications. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
         */
        
        case afterFirstUnlockThisDeviceOnly
        
        /**
         The data in the keychain item can always be accessed regardless of whether the device is locked.
         
         This is not recommended for application use. Items with this attribute migrate to a new device when using encrypted backups.
         */
        
        case always
        
        /**
         The data in the keychain can only be accessed when the device is unlocked. Only available if a passcode is set on the device.
         
         This is recommended for items that only need to be accessible while the application is in the foreground. Items with this attribute never migrate to a new device. After a backup is restored to a new device, these items are missing. No items can be stored in this class on devices without a passcode. Disabling the device passcode causes all items in this class to be deleted.
         */
        
        case whenPasscodeSetThisDeviceOnly
        
        /**
         The data in the keychain item can always be accessed regardless of whether the device is locked.
         
         This is not recommended for application use. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
         */
        
        case alwaysThisDeviceOnly
        
        /**
         The data in the keychain item can be accessed only while the device is unlocked by the user.
         
         This is recommended for items that need to be accessible only while the application is in the foreground. Items with this attribute migrate to a new device when using encrypted backups.
         
         This is the default value for keychain items added without explicitly setting an accessibility constant.
         */
        
        case whenUnlocked
        
        /**
         The data in the keychain item can be accessed only while the device is unlocked by the user.
         
         This is recommended for items that need to be accessible only while the application is in the foreground. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
         */
        
        case whenUnlockedThisDeviceOnly
        
        public var rawValue: CFString {
            switch self {
            case .afterFirstUnlock:
                return kSecAttrAccessibleAfterFirstUnlock
            case .afterFirstUnlockThisDeviceOnly:
                return kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            case .always:
                return kSecAttrAccessibleAlways
            case .whenPasscodeSetThisDeviceOnly:
                return kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
            case .alwaysThisDeviceOnly:
                return kSecAttrAccessibleAlwaysThisDeviceOnly
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
            case kSecAttrAccessibleAlways:
                self = .always
            case kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly:
                self = .whenPasscodeSetThisDeviceOnly
            case kSecAttrAccessibleAlwaysThisDeviceOnly:
                self = .alwaysThisDeviceOnly
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
