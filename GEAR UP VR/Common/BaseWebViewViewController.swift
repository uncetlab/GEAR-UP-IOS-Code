//
//  BaseWebView_ViewController.swift
//  GEAR UP VR
//
//  Created by Ansarsha on 05/03/20.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import SafariServices
import UIKit
import WebKit

class BaseWebViewViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - WKNavigationDelegate methods

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url {
                if webView.url?.host != url.host {
                    showWebviewDecisionAlert(url: url)
                    decisionHandler(.cancel)
                } else {
                    decisionHandler(.allow)
                }
            }
        } else {
            decisionHandler(.allow)
        }
    }

    func showWebviewDecisionAlert(url: URL) {
        if !UIApplication.shared.canOpenURL(url) {
            let message: String = ErrorMessages.errorToLoadURL
            showStandardAlert(message: message)
        }

        let bundleName = Bundle.main.displayName

        let alert = UIAlertController(title: bundleName, message: WebViewAlert.message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: WebViewAlert.inAppBrowser, style: UIAlertAction.Style.default, handler: { _ in

            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let nativeBrowser = SFSafariViewController(url: url, configuration: config)
            self.present(nativeBrowser, animated: true)

        }))

        alert.addAction(UIAlertAction(title: WebViewAlert.externalBrowser, style: UIAlertAction.Style.default, handler: { _ in

            UIApplication.shared.open(url)

        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
