//
//  VersionCheck.swift
//  SwiftyUpdateNotifier
//
//  Created by mac on 04/02/21.
//

import Foundation
import UIKit

class VersionCheck {
    
    static let shared = VersionCheck()
    
    func isUpdateAvailable(code: CountryCode, appId: String, window: UIWindow, versionLocal: String, appstoreUrl: String, updationTitle: String, updationMessage: String, callback: @escaping (Bool)->Void) {
        
        let repository = Repository(apiClient: APIClient(), url: "http://itunes.apple.com/\(code.rawValue)/lookup?id=\(appId)")
        
        repository.getVersion { (result) in
          
            switch result {
            case .success(let items):
                
                let versionStore = items.results![0].version!
                
                let storeNumStr = versionStore.replacingOccurrences(of: ".", with: "")
                let localNumStr = versionLocal.replacingOccurrences(of: ".", with: "")
                
                let storeNum = Int(storeNumStr)!
                let localNum = Int(localNumStr)!
                
                if storeNum == localNum {
                    callback(false)
                    print("Already Updated!!!")
                } else if storeNum > localNum {
                    
                    
                    let alert = UIAlertController(title: updationTitle, message: updationMessage, preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Skip For Now", style: .default) { (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }
                    let positiveAction = UIAlertAction(title: "Update Now", style: .default) { (action) in
                        if let url = URL(string: appstoreUrl) {
                            UIApplication.shared.open(url)
                        }
                    }
                    alert.addAction(positiveAction)
                    alert.addAction(action1)
                    window.rootViewController?.present(alert, animated: true, completion: nil)
                    callback(true)
                    
                } else {
                    callback(false)
                    print("NOT A CASE")
                }
                
            case .failure(let error):
                print("\(self) retrive error \(error)")
            }
            
        }
        
        
    }
    
}


enum CountryCode : String {
    case india = "in"
    case uae = "ae"
}
