//
//  SystemLayoutViewController.swift
//  HT_SwiftDemo
//
//  Created by 陈竹青 on 2023/7/3.
//

import UIKit

class SystemLayoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        //初始化布局
        let view1 = buildNewView()
        let view2 = buildNewView()
        let view3 = buildNewView()
        view.addSubview(view1)
        view.addSubview(view2)
        view.addSubview(view3)
        //水平布局
        view1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        view1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        view1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        view2.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
        view2.leftAnchor.constraint(equalTo: view1.rightAnchor,constant: 10).isActive = true
        view2.heightAnchor.constraint(equalTo: view1.heightAnchor, multiplier: 1).isActive = true
        view2.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 1).isActive = true
        
        view3.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 10).isActive = true
        view3.leftAnchor.constraint(equalTo: view1.leftAnchor).isActive = true
        view3.rightAnchor.constraint(equalTo: view2.rightAnchor).isActive = true
        view3.heightAnchor.constraint(equalTo: view1.heightAnchor, multiplier: 1).isActive = true
        
        
    }
    
    private func buildNewView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.random
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
