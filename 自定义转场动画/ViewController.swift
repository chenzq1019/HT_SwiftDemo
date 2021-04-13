//
//  ViewController.swift
//  自定义转场动画
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var mTableView: UITableView = { [unowned self] in
        let view = UITableView(frame: self.view.bounds, style: .plain)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 100
        return view
    }()
    
    var currentIndexPath : IndexPath?
    
    var dataArray : [String] = ["Present / Dismiss转场- 3D","Present / Dismiss转场- Sheet","Present / Dismiss转场- Alert","Push / Pop 转场","push Normal"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(mTableView)
        loadData()
    }
    func loadData() -> Void {
        self.title = "转场动画"
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.imageView?.image = UIImage(named: "piao.png")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = PrentViewController()
            vc.animation.type = .Aniamtion3DTransform
            self.present(vc, animated: true, completion: nil)
        }
        if indexPath.row == 1 {
            let vc = PrentViewController()
            vc.animation.type = .AniamtionSheetType
            self.present(vc, animated: true, completion: nil)
        }
        if indexPath.row == 2 {
            let vc = PrentViewController()
            vc.animation.type = .AniamtionAlertType
            vc.animation.viewSize = CGSize(width: 300, height: 400)
            self.present(vc, animated: true, completion: nil)
        }
        if indexPath.row == 3 {
            let vc = PushViewController()
            currentIndexPath = indexPath
            self.navigationController?.delegate = vc
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 4 {
            let vc = GallerisViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

