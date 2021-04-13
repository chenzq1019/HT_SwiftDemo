//
//  StackDemoVC01.swift
//  StackViewDemo
//
//  Created by 陈竹青 on 2021/3/31.
//

import UIKit

class StackDemoVC01: UIViewController {
    lazy var scrollView : UIScrollView = {
        let view = UIScrollView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: self.view.frame.height))
        return view
    }()
    
    lazy var stackView : UIStackView = {[unowned self] in
        let view = UIStackView(frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width - 20, height: 200))
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        view.alignment = .fill
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor =  .white
        
        let titles = ["测试","测试测试测","测试测试测试","测试测试测试AB","测试测试测试ABCD","测试","测试测试测试"]
        
        for i in 0..<titles.count {
            let view = UIView()
            view.backgroundColor = .red
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
            let label = UILabel()
            label.text = titles[i]
            view.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.edges.equalTo(view)
            }
            
            self.stackView.addArrangedSubview(view)
        }
        self.scrollView.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.scrollView)
            make.top.bottom.equalTo(self.scrollView)
        }

        self.view.addSubview(self.scrollView)
        
//        self.view.addSubview(self.stackView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
