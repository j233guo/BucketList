//
//  Helpers.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-09.
//

import Foundation
import LocalAuthentication

func getDocumentsDirectory() -> URL {
    // Find all possible document directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // Just send back the first one, which ought to be the only one
    return paths[0]
}

func getUrl(filename str: String) -> URL {
    return getDocumentsDirectory().appendingPathComponent(str)
}

enum AuthState {
    case success
    case fail
    case error
    case unavailable
}

func authenticate() -> AuthState {
    let context = LAContext()
    var error: NSError?
    var state: AuthState = .fail
    // Check if biometric authentication is possible
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        // If possible, go ahead and use it
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need to unlock your data") { success, authenticationError in
            if success {
                state = .success
            } else {
                state = .error
            }
        }
    } else {
        state = .unavailable
    }
    return state
}
