//
//  SNSLoginService.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/21.
//

import Foundation
import UIKit
import AuthenticationServices

protocol SNSLoginServiceType {
    init(_ context: UIViewController)
}

class SNSLoginService: NSObject, SNSLoginServiceType{
    var context: UIViewController
    
    required init(_ context: UIViewController) {
        self.context = context
    }
    func onAppleID() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
}
extension SNSLoginService: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let userFirstName = appleIDCredential.fullName?.givenName == nil ? "" : appleIDCredential.fullName?.givenName
            let userLastName = appleIDCredential.fullName?.familyName == nil ? "" : appleIDCredential.fullName?.familyName
            let userEmail = appleIDCredential.email == nil ? "" : appleIDCredential.email
            
//            UserDefaults.standard.set(true, forKey: "isApple")
//            UserDefaults.standard.set(userFirstName! + userLastName!, forKey: "appleUserName")
            print("userIdentifier \(userIdentifier)") //보장된 값
            print("userFirstName \(userFirstName)")
            print("userLastName \(userLastName)")
            print("userEmail \(userEmail)")
            
//            userIdentifier 001700.f99e71ad08744fd58ce8257d8a70e765.0445
//            userFirstName Optional("")
//            userLastName Optional("")
//            userEmail Optional("")
//            userIdentifier 001700.f99e71ad08744fd58ce8257d8a70e765.0445
//            userFirstName Optional("Glory")
//            userLastName Optional("Kim")
//            userEmail Optional("ikmujn5@naver.com")
            
            //Navigate to other view controller
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            print("username \(username)")
            print("password \(password)")
            //Navigate to other view controller
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // handle Error.
        
    }
}

extension SNSLoginService: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.context.view.window!
    }
}
