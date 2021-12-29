//
//  StackViewVC04.swift
//  StackViewDemo
//
//  Created by 陈竹青 on 2021/11/16.
//

import UIKit

class StackDemoVC04: UIViewController {
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.backgroundColor = .orange
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        let btn = UIButton()
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(self.stackView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(10)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        btn.setTitle("隐藏", for: .normal)
        btn.addTarget(self, action: #selector(clicAt), for: .touchUpInside)
        btn.backgroundColor = .blue
        
        let showBtn = UIButton()
        view.addSubview(showBtn)
        showBtn.snp.makeConstraints { (make) in
            make.top.equalTo(btn)
            make.left.equalTo(btn.snp.right).offset(10)
            make.size.equalTo(btn)
        }
        showBtn.backgroundColor = .blue
        showBtn.setTitle("显示", for: .normal)
        showBtn.addTarget(self, action: #selector(showBtnClick), for: .touchUpInside)
        
        let view0 = UIView()
        
        let view1 = UIView()
        let view2 = UIView()
        let array = [view0,view1,view2]
        for subView in array {
            subView.backgroundColor = .red
            subView.snp.makeConstraints { (make) in
                make.height.equalTo(60)
                make.width.equalTo(100)
            }
            stackView.addArrangedSubview(subView)
        }
        view2.snp.makeConstraints { (make) in
            make.width.equalTo(30)
        }
        
        
    }
    
    @objc func clicAt(btn:UIButton) ->Void{
        let array = self.stackView.arrangedSubviews;
        let subview = array[1];
        UIView.animate(withDuration: 0.3) {
            subview.isHidden = true
            self.stackView.layoutIfNeeded()
        }
        
        
    }
    
    @objc func showBtnClick(btn: UIButton) -> Void{
        let array = self.stackView.arrangedSubviews;
        let subview = array[1];
        UIView.animate(withDuration: 0.3) {
            subview.isHidden = false
            self.stackView.layoutIfNeeded()
        }
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
