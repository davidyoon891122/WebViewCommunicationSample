//
//  ViewController.swift
//  WebViewDiff
//
//  Created by iMac on 2022/11/23.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "system")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        

        view.addSubview(webView)

        
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureWebView()
    }

}

extension ViewController: WKScriptMessageHandler {
    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        if message.name == "system" {
            guard let body = message.body as? [String: String] else { return }
            print(body)
            let alert = UIAlertController(title: "Alert", message: "AlertMessage", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
    }
}



private extension ViewController {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    func configureWebView() {
        guard let htmlURL = Bundle.main.url(
            forResource: "home",
            withExtension: "html"
        ) else {
            print("Can't find a file")
            return
        }
        webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
    }
}
