//
//  UpgradeNotice.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/06/01.
//

import Foundation
import UIKit

class UpgradeNotice {
    internal static let shared = UpgradeNotice()
    private init() {}
    
    private let apple_id = "1569931121"
            
    internal func fire() {
        guard let url = URL(string: "https://itunes.apple.com/jp/lookup?id=\(apple_id)") else {
            return
        }
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                let jsonData = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                guard let storeVersion = ((jsonData?["results"] as? [Any])?.first as? [String : Any])?["version"] as? String,
                      let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
                    return
                }
                switch storeVersion.compare(appVersion, options: .numeric) {
                case .orderedDescending:
                    DispatchQueue.main.async {
                        self.showAlert()
                    }
                    return
                case .orderedSame, .orderedAscending:
                    return
                }
            }catch {
            }
        })
        task.resume()
    }
    
    private func showAlert()
    {
        guard let parent = topViewController() else {
            return
        }
        let actionA = UIAlertAction(title: "更新", style: .default, handler: {
                    (action: UIAlertAction!) in
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(self.apple_id)"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        let actionB = UIAlertAction(title: "あとで", style: .default, handler: {
                    (action: UIAlertAction!) in
        })
        
        let alert: UIAlertController = UIAlertController(title: "最新バージョンのお知らせ", message: "最新バージョンがあります。", preferredStyle: .alert)
        alert.addAction(actionA)
        alert.addAction(actionB)
        parent.present(alert, animated: true, completion: nil)
    }
        
    private func topViewController() -> UIViewController?
    {
        var vc = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first?.rootViewController
        while vc?.presentedViewController != nil {
            vc = vc?.presentedViewController
        }
        return vc
    }
}
