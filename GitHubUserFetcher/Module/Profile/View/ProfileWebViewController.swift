//
//  ProfileWebViewController.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 17/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import WebKit
import UIKit

class ProfileWebViewController: UIViewController
{
    // MARK: - Subview
    
    let webView = WKWebView()
    
    // MARK: - Variable
    
    private let url: URL
    
    // MARK: - Initailizer
    
    init(url: URL, title: String = "")
    {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView()
    {
        view = webView
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
}
