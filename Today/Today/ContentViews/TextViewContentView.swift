//
//  TextViewContentView.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/28.
//

import Foundation
import UIKit

class TextViewContentView: UIView, UIContentView{
  
    struct Configuration: UIContentConfiguration {
        var text: String? = ""
        var onChanged: (String) -> Void = {_ in}
        func makeContentView() -> UIView & UIContentView {
            return TextViewContentView(self)
        }
        func updated(for state: UIConfigurationState) -> TextViewContentView.Configuration {
            return self
        }
    }
    var configuration: UIContentConfiguration {
        didSet {
           configure(configuration: configuration)
        }
    }
    
    let textView = UITextView()
    
    override var intrinsicContentSize: CGSize{
        CGSize(width: 0, height: 44)
    }
    
    init(_ configuration: UIContentConfiguration){
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubView(textView,height: 200)
        textView.backgroundColor  = nil
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration){
        guard let configuration = configuration as? Configuration    else{return}
        textView.text = configuration.text
    }
    

}

extension TextViewContentView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let configuration = configuration as? TextViewContentView.Configuration    else{return}
        configuration.onChanged(textView.text)
    }
}

extension UICollectionViewListCell {
    func textViewConfiguration() -> TextViewContentView.Configuration{
        TextViewContentView.Configuration()
    }
}
