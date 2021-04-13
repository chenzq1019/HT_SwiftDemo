//
//  ViewController.swift
//  StackViewDemo
//
//  Created by 陈竹青 on 2021/3/30.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let dataArray : [String] = ["Demo01","Demo02","Demo03"]
    lazy var myTableView : UITableView = { [unowned self] in
        let view =  UITableView(frame: CGRect.zero,style: .plain)
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        return view
    }()
    
    lazy var scrollView : UIScrollView = {
        let view = UIScrollView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: self.view.frame.height))
        return view
    }()
    
    lazy var stackView : UIStackView = {[unowned self] in
        let view = UIStackView(frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width - 20, height: 200))
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        view.alignment = .fill
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let titles = ["测试","测试测试测","测试测试测试","测试测试测试AB","测试测试测试ABCD","测试","测试测试测试"]
//       
//        for i in 0..<titles.count {
//            let view = UIView()
//            view.backgroundColor = .red
//            let red = CGFloat(arc4random()%256)/255.0
//            let green = CGFloat(arc4random()%256)/255.0
//            let blue = CGFloat(arc4random()%256)/255.0
//            view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
//            let label = UILabel()
//            label.text = titles[i]
//            view.addSubview(label)
//            label.snp.makeConstraints { (make) in
//                make.edges.equalTo(view)
//            }
//            
//            self.stackView.addArrangedSubview(view)
//        }
//        self.scrollView.addSubview(self.stackView)
//        self.stackView.snp.makeConstraints { (make) in
//            make.left.right.equalTo(self.scrollView)
//            make.top.bottom.equalTo(self.scrollView)
//        }
//        
//        self.view.addSubview(self.scrollView)
        
        self.view.addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let storyboard1 = UIStoryboard.init(name: "StackDemoVC03", bundle: Bundle.main)
            let vc = storyboard1.instantiateViewController(identifier: "StackDemoVC03")
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        let workName = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
        let className = "StackDemoVC0\(indexPath.row + 1)"
        let class_VC = NSClassFromString("\(workName).\(className)") as! UIViewController.Type
        let vc = class_VC.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
