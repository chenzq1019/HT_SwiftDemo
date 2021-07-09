//
//  HTSelectView.swift
//  电影院选座Demo
//
//  Created by 陈竹青 on 2021/7/8.
//

import UIKit

class HTSelectView: UIView {
    
    lazy var seatScrollView : UIScrollView = { [unowned self] in
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.delegate = self
        scrollView.decelerationRate = .fast
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        
        return scrollView
    }()
    var selectedSeats : Array<UIButton> = []
    var btn : UIButton?
    var seatView : HTSeatsView?
    var rowindexView : HTRowIndexView?

    init(frame: CGRect,seatsArray: [HTSeatsModel] ,hallName:String, actionBlock:@escaping (_ btn: UIButton,_ allAvailableSeats:Dictionary<String,UIButton>)->Void) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.addSubview(self.seatScrollView)
        self.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
        initSeatsView(seatsArray: seatsArray)
        initRowIndexView(seatsArray: seatsArray)
        startAnimation()
    }
    
    func startAnimation() -> Void {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut) {[unowned self] in
            let zoomRect = zonmRectInView(view: self.seatScrollView, scale: 25, center: CGPoint(x: CGFloat(self.seatView!.seatBtnWidth) / 2, y: 0))
            self.seatScrollView.zoom(to: zoomRect, animated: true)
        } completion: { (finish) in
            
        }

    }
    
    func zonmRectInView(view: UIView,scale:CGFloat,center:CGPoint) -> CGRect{
        var rect = CGRect()
        rect.size.height = view.bounds.size.height / scale
        rect.size.width = view.bounds.size.width / scale
        rect.origin.x = center.x - rect.size.width / 2.0
        rect.origin.y = center.y - rect.size.height / 2.0
        return rect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSeatsView(seatsArray:[HTSeatsModel]) -> Void {
        let seatView = HTSeatsView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), seatArray: seatsArray, maxWidth: Float(self.bounds.width)) { (btn) in
            
        }
        seatView.frame = CGRect(x: 0, y: 0, width: CGFloat(seatView.seatViewWidth), height: CGFloat(seatView.seatViewHeight))
        self.seatScrollView.addSubview(seatView)
        self.seatView = seatView
    }
    
    func initRowIndexView(seatsArray:[HTSeatsModel]) -> Void {
        let rowindexView = HTRowIndexView(frame: CGRect(x: self.seatScrollView.contentOffset.x, y: -CGFloat(10), width: CGFloat(13), height: CGFloat((self.seatView?.frame.height)! + 2 * 10)))
        rowindexView.indexsArray = seatsArray
        self.seatScrollView.addSubview(rowindexView)
        self.rowindexView = rowindexView
    }
}

extension HTSelectView: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("开始缩放")
        self.btn?.center = scrollView.center
        self.rowindexView?.height = self.seatView!.frame.height + 2 * 10
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print("====结束缩放====\(scale)")
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.seatView
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.rowindexView?.frame = CGRect(x: scrollView.contentOffset.x + 10, y: self.rowindexView!.frame.origin.y, width: self.rowindexView!.frame.width, height: self.rowindexView!.frame.height);
        
    }
}
