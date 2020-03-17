//
//  AppDelegate.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/22.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import SwiftyBeaver
import Firebase
import FirebaseAuth
import GoogleSignIn
import UserNotifications

let log = SwiftyBeaver.self

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        setupFabric()
        setupSwiftyBeaver()
        setupFirebase()
        setupGoogleSignIn()
        applyTheme()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
            if granted {
                print("使用者同意了，每天都能收到來自米花兒的幸福訊息")
            }
            else {
                print("使用者不同意，不喜歡米花兒，哭哭!")
            }

        })

        return true
    }
    
}

//extension AppDelegate {
//    
//    @available(iOS 9.0, *)
//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        return GIDSignIn.sharedInstance().handle(url,
//                                                 sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//                                                 annotation: [:])
//    }
//    
//}

extension AppDelegate {

    func setupSwiftyBeaver() {
        // add log destinations. at least one is needed!
        let console = ConsoleDestination()  // log to Xcode Console
        let file = FileDestination()  // log to default swiftybeaver.log file
        let cloud = SBPlatformDestination(appID: "MmnRZ7", appSecret: "noarUzP7agwkSuqiesbcy0auonjynMOt", encryptionKey: "hjgKwmrp8cywcdulqoyH72jniqc8elfm") // to cloud
        
        // use custom format and set console output to short time, log level & message
        console.format = "$DHH:mm:ss.SSS$d $C$L$c $N.$F:$l - $M"
        // or use this for JSON output: console.format = "$J"
        
        // add the destinations to SwiftyBeaver
        log.addDestination(console)
        log.addDestination(file)
        log.addDestination(cloud)
    }
    
    func setupFirebase() {
        FirebaseApp.configure()
    }
    
    func applyTheme() {
        if UserDefaults.standard.object(forKey: "kIsDarkTheme") == nil {
            UserDefaults.standard.set(false, forKey: "kIsDarkTheme")
            Theme.current = LightTheme()
        } else {
            Theme.current = UserDefaults.standard.bool(forKey: "kIsDarkTheme") ? DarkTheme() : LightTheme()
        }
    }
    
}

// MARK: - Google Sign In

extension AppDelegate: GIDSignInDelegate {
    
    func setupGoogleSignIn() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        if loginManager.isLogin && loginManager.accountProvider == "google" {
            loginManager.signInSilently = true
            GIDSignIn.sharedInstance().restorePreviousSignIn()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
        if let error = error {
            log.error("Google Sign In Error: \(error.localizedDescription)")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AuthLogin"), object: nil, userInfo: ["Error": "\(error.localizedDescription)"])
            return
        }
        
        guard let authentication = user.authentication else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AuthLogin"), object: nil, userInfo: ["Error": "authentication error"])
            return
        }
        
        loginManager.accountProvider = "google"
        
        log.info("Google Sign in Succeed")
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AuthLogin"), object: nil, userInfo: ["credential": credential])
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        if let error = error {
            log.error("Signing Out Error: \(error.localizedDescription)")
            return
        }
        
        //
        log.info("Google Signing Out Succeed")
    }

}

extension AppDelegate {

    func presentAlertView(_ title: String?, message: String?, completion: (() -> Void)? = nil) {
        let visibleViewController = window?.visibleViewController
        visibleViewController?.presentAlertView(title, message: message, completion: completion)
    }

}
