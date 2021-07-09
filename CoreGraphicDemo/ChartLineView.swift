//
//  ChartLineView.swift
//  CoreGraphicDemo
//
//  Created by 陈竹青 on 2021/7/2.
//

import UIKit

class ChartLineView: UIView {
    
    lazy var chartScrollView: UIScrollView = {[unowned self] in
        let scrollView = UIScrollView.init(frame: CGRect(x: 30, y: 0, width: self.bounds.size.width - 30, height: self.bounds.size.height))
        scrollView.contentOffset = CGPoint.zero
        scrollView.backgroundColor = .clear
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: self.bounds.size.width * 2, height: 0)
        return scrollView
    }()
    lazy var pageController: UIPageControl = {[unowned self] in
        let controller = UIPageControl.init(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        controller.center = CGPoint(x: self.chartScrollView.center.x, y: self.chartScrollView.frame.maxY)
        controller.bounds = CGRect(x: 0, y: 0, width: 60, height: 30)
        controller.numberOfPages = 2
        controller.pageIndicatorTintColor = .lightGray
        controller.currentPageIndicatorTintColor = .blue
        controller.currentPage = 0
        
        return controller
    }()
    lazy var scrollBgView1 :UIView = {[unowned self] in
        let bgView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.chartScrollView.bounds.size.width-5, height: self.chartScrollView.bounds.size.height))
        return bgView
    }()
    lazy var scrollBgView2 :UIView = {[unowned self] in
        let bgView = UIView.init(frame: CGRect(x: self.chartScrollView.bounds.size.width, y: 0, width: self.chartScrollView.bounds.size.width-5, height: self.chartScrollView.bounds.size.height))
        return bgView
    }()
    lazy var bgView1: UIView = {[unowned self] in
        let bgView = UIView.init(frame: CGRect(x: 5, y: 0, width: self.chartScrollView.bounds.size.width-20, height: self.scrollBgView1.bounds.size.height-60))
        bgView.backgroundColor = .white
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 5
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1).cgColor
        return bgView
    }()
    lazy var bgView2: UIView = {[unowned self] in
        let bgView = UIView.init(frame: CGRect(x: 5, y: 0, width: self.chartScrollView.bounds.size.width-20, height: self.scrollBgView2.bounds.size.height-60))
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 5
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1).cgColor
        return bgView
    }()
    var Ymargin : CGFloat = 0.0
    
    var Xmargin : CGFloat  = 0.0
    
    var leftBtnArray : Array<UIButton> = []
    var leftPointArray : Array<NSValue> = []
    
    var leftArray : Array<String> = []
    
    var leftDataArray : Array<String>  = [] {
        willSet(value){
            leftArray = value
            addDataPoint(bgView: self.scrollBgView1, array: value)
            addLeftBezierPoint()
        }
    }
    var lastPoint : CGPoint?
    override init(frame: CGRect) {
        super.init(frame: frame);
        addDetailViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//UI
extension ChartLineView {
    func addDetailViews(){
        self.addSubview(self.chartScrollView)
        self.addSubview(self.pageController)
        self.chartScrollView.addSubview(self.scrollBgView1)
        self.chartScrollView.addSubview(self.scrollBgView2)
        self.scrollBgView1.addSubview(self.bgView1)
        self.scrollBgView2.addSubview(self.bgView2)
        addlineToView(targetView: self.bgView1)
        addlineToView(targetView: self.bgView2)
        addLeftViews()
        addBottomViewTo(view: self.scrollBgView1)
        addBottomViewTo(view: self.scrollBgView2)
    }
    func addlineToView(targetView:UIView) -> Void {
        let marginHeight :CGFloat = targetView.bounds.size.height / 5
        let labelWidth : CGFloat = targetView.bounds.size.width
        Ymargin = marginHeight
        
        for i in 0..<4 {
            let label: UILabel = UILabel.init(frame: CGRect(x: 0, y: marginHeight + marginHeight * CGFloat(i), width: labelWidth, height: 1))
            label.backgroundColor = UIColor(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
            targetView.addSubview(label)
        }
        
        let marginWidth : CGFloat = targetView.bounds.size.width / 6
        Xmargin = marginWidth
        let lableHeght : CGFloat = targetView.bounds.size.height
        
        for i in 0..<6 {
            let label : UILabel = UILabel(frame: CGRect(x: marginWidth*CGFloat(i), y: 0, width: 1, height: lableHeght))
            label.backgroundColor =  UIColor(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
            if i != 0 {
                targetView.addSubview(label)
            }
        }
        
    }
    func addLeftViews() -> Void {
        
        let leftArray:Array = ["5.00","4.00","3.00","2.00","1.00","0.00"]
        for (i, str) in leftArray.enumerated() {
            let leftLabel : UILabel = UILabel.init(frame: CGRect(x: 0, y: CGFloat(i)*(Ymargin-2)-10, width: 30, height: 30))
            leftLabel.textColor = .gray
            leftLabel.font = UIFont.systemFont(ofSize: 12)
            leftLabel.text = str
            self.addSubview(leftLabel)
        }
    }
    
    func addBottomViewTo(view:UIView) -> Void {
        var bottomArray : Array<String>
        if view.isEqual(self.scrollBgView1) {
            bottomArray = ["一月","二月","三月","四月","五月","六月"]
        }else{
            bottomArray = ["七月","八月","九月","十月","十一月","十二月"];
        }
        for (i,str) in bottomArray.enumerated(){
            let label =  UILabel(frame: CGRect(x: Xmargin+CGFloat(i)*Xmargin-12, y: 5*Ymargin, width: 50, height: 30))
            label.textColor = .black
            label.font =  UIFont.systemFont(ofSize: 10)
            label.text = str
            label.textAlignment = .left
            view.addSubview(label)
        }
    }
    
    func addDataPoint(bgView: UIView, array:[String]) -> Void {
        self.leftArray = array
        let height:CGFloat = self.bgView1.bounds.size.height
        var startArray :Array<String> = array
        startArray.insert("0.8", at: 0)
        
        for (i, str) in startArray.enumerated() {
            let value : CGFloat = CGFloat(Double(str) ?? 0)
            let btn = UIButton(frame: CGRect(x: Xmargin * CGFloat(i), y: value * height, width: 12, height: 12))
            btn.backgroundColor = .white
            btn.layer.borderColor = UIColor(red: 0.0, green: 122/255.0, blue: 233/255.0, alpha: 1).cgColor
            btn.layer.borderWidth = 1
            btn.layer.cornerRadius =  6
            btn.layer.masksToBounds = true
            btn.tag = i
//            if i == 0 {
//
//            }
            btn.addTarget(self, action: #selector(clickAt(btn:)), for: .touchUpInside)
            self.leftBtnArray.append(btn)
            
            let point = NSValue(cgPoint: btn.center)
            self.leftPointArray.append(point)
            
        }
        print(self.leftPointArray)
        
    }
    
    func addLeftBezierPoint() -> Void {
        //取得起始点
        let p1 : CGPoint = self.leftPointArray[0].cgPointValue
        print("\(p1.x) \(p1.y)")
        //直线的连线
        let beizer : UIBezierPath = UIBezierPath()
        beizer.move(to: p1)
        
        //遮罩层的形状
        let beizer1 : UIBezierPath = UIBezierPath()
        beizer1.lineCapStyle = .round
        beizer1.lineJoinStyle = .miter
        beizer1.move(to: p1)
        
        for (i,point) in self.leftPointArray.enumerated() {
            if i != 0 {
                let tempPoint = point.cgPointValue
                print(tempPoint)
                beizer.addLine(to: tempPoint )

                beizer1.addLine(to: tempPoint )
                if i == self.leftBtnArray.count - 1 {
                    beizer.move(to: tempPoint )
                    self.lastPoint = tempPoint
                }
            }
        }
        
        let bgViewHeight : CGFloat = self.bgView1.bounds.size.height
        
        let lastPointX = self.lastPoint!.x
        
        let lastPointX1 = CGPoint(x: lastPointX, y: bgViewHeight)
        
        beizer1.addLine(to: lastPointX1)
        
        beizer1.addLine(to: CGPoint(x: p1.x, y: bgViewHeight))
        
        beizer1.addLine(to: p1)
        
        let shadeLayer = CAShapeLayer()
        shadeLayer.path = beizer1.cgPath
        shadeLayer.fillColor = UIColor.green.cgColor
        
        let graientLayer = CAGradientLayer()
        graientLayer.frame = CGRect(x: 5, y: 0, width: 0, height: self.scrollBgView1.bounds.size.height-60)
        graientLayer.startPoint = CGPoint(x: 0, y: 0)
        graientLayer.endPoint = CGPoint(x: 0, y: 1)
        graientLayer.cornerRadius = 5
        graientLayer.masksToBounds = true
        graientLayer.colors = [UIColor(red: 166/255.0, green: 206/255.0, blue: 247/255.0, alpha: 0.7).cgColor,UIColor(red: 237/255.0, green: 246/255.0, blue: 253/255.0, alpha: 0.5).cgColor]
        graientLayer.locations = [NSNumber(0.5)]
        
        
        let baseLayer = CALayer()
        baseLayer.addSublayer(graientLayer)
        baseLayer.mask = shadeLayer
        
        self.scrollBgView1.layer.addSublayer(baseLayer)
        
        let animal1 = CABasicAnimation(keyPath: "bounds")
        animal1.keyPath = "bounds"
        animal1.duration = 5.2
        animal1.toValue =  NSValue(cgRect: CGRect(x: 5, y: 0, width:  2*lastPoint!.x, height: self.scrollBgView1.bounds.size.height-60))
        animal1.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animal1.fillMode = .forwards
        animal1.autoreverses = false
        animal1.isRemovedOnCompletion = false
        
        graientLayer.add(animal1, forKey: "bounds")
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = beizer.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 0, green: 120/250.0, blue: 233/250.0, alpha: 1).cgColor
        shapeLayer.lineWidth = 2
        self.scrollBgView1.layer.addSublayer(shapeLayer)
        
        let animal2 = CABasicAnimation(keyPath: "strokeEnd")
        animal2.fromValue = NSNumber(0)
        animal2.toValue = NSNumber(1.0)
        animal2.duration = 5
        animal2.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animal2.autoreverses = false
        
        shapeLayer.add(animal2, forKey: "stroke")
        
        for btn in self.leftBtnArray {
            self.scrollBgView1.addSubview(btn)
        }
        
        
        
    }
    
    @objc func clickAt(btn: UIButton){
        
    }
}


extension ChartLineView : UIScrollViewDelegate {
    
}
