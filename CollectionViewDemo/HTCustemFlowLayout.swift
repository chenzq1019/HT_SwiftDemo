//
//  HTCustemFlowLayout.swift
//  CollectionViewDemo
//
//  Created by 陈竹青 on 2021/8/13.
//

import UIKit

class HTCustemFlowLayout: UICollectionViewFlowLayout {
    fileprivate var longPress : UILongPressGestureRecognizer?
    fileprivate var panGesture: UIPanGestureRecognizer?
    
    fileprivate var cellFakeView: HTImageCell?
    // MARK: - lifyCycle
    override init() {
        super.init()
        configureObserver()
    }
    // -
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributesArray = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
//        attributesArray.filter {
//            $0.representedElementCategory == .cell
//        }.filter {
//            $0.indexPath ==
//        }
//
        return attributesArray
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "collectionView" {
            setUpGestureRecognizers()
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    fileprivate func configureObserver() {
        addObserver(self, forKeyPath: "collectionView", options: [], context: nil)
    }
    
    fileprivate func setUpGestureRecognizers() {
        guard let collectionView = collectionView else { return }
        guard longPress == nil && panGesture == nil else {return }
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(HTCustemFlowLayout.handleLongPress(_:)))
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(HTCustemFlowLayout.handlePanGesture(_:)))
        longPress?.delegate = self
        panGesture?.delegate = self
        panGesture?.maximumNumberOfTouches = 1
        let gestures: NSArray! = collectionView.gestureRecognizers as NSArray?
        gestures.enumerateObjects(options: []) { gestureRecognizer, index, finish in
            if gestureRecognizer is UILongPressGestureRecognizer {
                (gestureRecognizer as AnyObject).require(toFail: self.longPress!)
            }
            collectionView.addGestureRecognizer(self.longPress!)
            collectionView.addGestureRecognizer(self.panGesture!)
            }
        }
    
    @objc func handleLongPress(_ longPress:UILongPressGestureRecognizer!){
        let location = longPress.location(in: collectionView)
//        print(location)
        var indexPath: IndexPath? = collectionView?.indexPathForItem(at: location)
//        print(indexPath?.row)
        if let cellFakeView = cellFakeView {
            
        }
        guard let pressIndexPath = indexPath else {
            return
        }
        switch longPress.state {
        case .began:
            let currentCell: HTImageCell = collectionView?.cellForItem(at: pressIndexPath) as! HTImageCell
            currentCell.indexPath = indexPath
            currentCell.originalCenter = currentCell.center
            currentCell.cellFrame = layoutAttributesForItem(at: indexPath!)?.frame
        
            collectionView?.addSubview(currentCell)
            currentCell.pushFowardView()
            self.cellFakeView = currentCell
            
        case .cancelled, .ended :
            
            cancelDrag()
            
        default:
            break
        }
        
    }
    
    fileprivate func cancelDrag(){
        guard self.cellFakeView != nil else {
            return
        }
        self.cellFakeView?.pushBackView(){
//            self.cellFakeView!.removeFromSuperview()
            self.cellFakeView = nil
            
        }
    }
    
    @objc func handlePanGesture(_ pan: UIPanGestureRecognizer!){
        let point = pan.translation(in: collectionView)
        print(point)
    }
    
    // gesture recognize delegate
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // allow move item
        let location = gestureRecognizer.location(in: collectionView)
//        if let indexPath = collectionView?.indexPathForItem(at: location) ,
//            delegate?.collectionView(self.collectionView!, allowMoveAt: indexPath) == false {
//            return false
//        }
//
        switch gestureRecognizer {
        case longPress:
            return !(collectionView!.panGestureRecognizer.state != .possible && collectionView!.panGestureRecognizer.state != .failed)
        case panGesture:
            return !(longPress!.state == .possible || longPress!.state == .failed)
        default:
            return true
        }
    }
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        switch gestureRecognizer {
        case panGesture:
            return otherGestureRecognizer == longPress
        case collectionView?.panGestureRecognizer:
            return (longPress!.state != .possible || longPress!.state != .failed)
        default:
            return true
        }
    }
}

extension HTCustemFlowLayout:UIGestureRecognizerDelegate{
    
    
}
