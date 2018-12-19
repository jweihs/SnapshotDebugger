//
//  ViewController.swift
//  SnapshotDebugger
//
//  Created by Jonathan Weihs on 18.12.18.
//  Copyright © 2018 Jonathan Weihs. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    
    //MARK: IBOutlet
    
    @IBOutlet weak var webViewContainerView: UIView!
    @IBOutlet weak var takeSnapshotButton: UIButton!
    @IBOutlet weak var reloadWebViewButton: UIButton!
    
    var webView: WKWebView?
    
    
    //MARK: Data Model
    
    fileprivate var snapshotCount: Int = 0 {
        didSet {
            self.takeSnapshotButton.setTitle("\(snapshotCount) Snapshots taken", for: .normal)
        }
    }
    
    
    //MARK: IBAction
    
    @IBAction fileprivate func takeSnapshotButtonTapped(_ sender: Any) {
        self.takeSnapshots()
        self.takeSnapshotButton.flashView()
    }
    
    @IBAction fileprivate func reloadWebViewButtonTapped(_ sender: Any) {
        self.reloadWebView()
        self.reloadWebViewButton.flashView()
    }
    
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInterface()
    }

    
    //MARK: Private Interface
    
    fileprivate func setupInterface() {
        self.takeSnapshotButton.layer.borderColor = UIColor.lightGray.cgColor
        self.reloadWebViewButton.layer.borderColor = UIColor.lightGray.cgColor
        self.takeSnapshotButton.layer.borderWidth = 1
        self.reloadWebViewButton.layer.borderWidth = 1
        self.setupWebView()
    }
    
    fileprivate func takeSnapshots(_ count: Int = 200) {
        for i in 0..<count {
            delay(TimeInterval(i)  * 0.01) {
                self.view.snapshotView(afterScreenUpdates: true)
                self.snapshotCount += 1
            }
        }
    }
    
    fileprivate func reloadWebView() {
        let htmlFile = Bundle.main.path(forResource: "test", ofType: "html")
        let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        webView?.loadHTMLString(html!, baseURL: nil)
    }
    
    fileprivate func setupWebView() {
        let newWebView = WKWebView(frame: self.webViewContainerView.bounds)
        self.webViewContainerView.addSubview(newWebView)
        newWebView.pinEdges(to: self.webViewContainerView)
        self.webView = newWebView
        self.reloadWebView()
    }

}


//Some Helper
func delay(_ delay: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

extension UIView {
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
}

extension UIView {
    func flashView() {
        let previousColor = self.backgroundColor
        self.backgroundColor = UIColor.lightGray
        UIView.animate(withDuration: 0.4) {
            self.backgroundColor = previousColor
        }
    }
}
