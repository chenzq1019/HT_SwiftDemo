//
//  ViewController.swift
//  WKWebViewDemo
//
//  Created by 陈竹青 on 2021/4/22.
//
/**
 * 这个是在wkwebView中，使用原生控件替换webView中的部分元素，用来优化webView页面的加载速度。
 * 
 */


import UIKit
import WebKit
import Foundation


class ViewController: UIViewController {
    lazy var mWebView : WKWebView = { [unowned self] in
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        webView.navigationDelegate = self
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(self.mWebView)
        let request = URLRequest(url: URL(string: "https://www.baidu.com")!)
        self.mWebView.load(request)
        self.loadHtmlData()
    }
    
    func loadHtmlData() -> Void {
        let dataInfo = FileManager.default.contents(atPath: Bundle.main.path(forResource: "articleContent", ofType: "txt")!)
        
        do{
            let dic = try JSONSerialization.jsonObject(with: dataInfo!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            print(dic)
            
            let string : String = dic["articleContent"] as! String
            self.mWebView.loadHTMLString(string , baseURL: nil)
        }catch{
            
        }
    }


}

extension ViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finshed====")
        let str = "(function(){var componentFrameDic=[];var list= document.getElementsByClassName('web-component');for(var i=0;i<list.length;i++){var dom = list[i];componentFrameDic.push({'index':dom.getAttribute('component-index'),'top':dom.offsetTop,'left':dom.offsetLeft,'width':dom.clientWidth,'height':dom.clientHeight});}return componentFrameDic;}())"
        DispatchQueue.main.async {
            self.mWebView.evaluateJavaScript(str) { (obj, error) in
                guard let array = obj  as? Array<NSDictionary> else{ return }
                
                for dic in array{
                    print(dic)
                    let x : CGFloat = dic["left"] as! CGFloat
                    let y = dic["top"] as! CGFloat
                    let width = dic["width"] as! CGFloat
                    let height = dic["height"] as! CGFloat
                    let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                    view.backgroundColor = .red
                    self.mWebView.scrollView.addSubview(view)
                }
            }
        }

    }
}
