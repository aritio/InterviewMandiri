//
//  WebViewViewController.swift
//  Mandiri
//

//

import UIKit

class WebViewViewController: BaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var WebView: UIWebView!
    
    var url = ""
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebView?.delegate = self
        loadWebView(url: url)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnBack.layer.cornerRadius = 6
        makeRounded(view: btnBack)
    }
    
    func loadWebView(url: String) {
        if url != "" {
            WebView.scalesPageToFit = true
            let url = URL (string: url)
            let requestObj = URLRequest(url: url!)
            WebView.scrollView.minimumZoomScale = 1.0;
            WebView.scrollView.maximumZoomScale = 1.0;
            WebView.loadRequest(requestObj)
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Artikel", bundle: nil)
        let secondVc = storyboard.instantiateViewController(withIdentifier: "ArtikelViewController") as! ArtikelViewController
        secondVc.id = self.id
        secondVc.modalPresentationStyle = .fullScreen
        secondVc.modalTransitionStyle = .crossDissolve
                
        present(secondVc, animated: true, completion: nil)
    }
    
}

extension WebViewViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        showLoading()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
