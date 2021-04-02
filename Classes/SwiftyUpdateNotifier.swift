//
//  SwiftyUpdateNotifier.swift
//  SwiftyUpdateNotifier
//
//  Created by mac on 04/02/21.
//

import Foundation
import UIKit

public class SwiftyUpdateNotifier {
    
    public static func checkVersion(code: CountryCode, appId: String, window: UIWindow, versionLocal: String, appstoreUrl: String, updationTitle: String, updationMessage: String, callback: @escaping (Bool)->Void) {
        VersionCheck.shared.isUpdateAvailable(code: code, appId: appId, window: window, versionLocal: versionLocal, appstoreUrl: appstoreUrl, updationTitle: updationTitle, updationMessage: updationMessage) { (val) in
            callback(val)
        }
    }
    
    
}
