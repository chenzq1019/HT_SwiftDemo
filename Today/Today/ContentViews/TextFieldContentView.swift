//
//  TextFieldContentView.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/28.
//

import UIKit

class TextFieldContentView: UIView , UIContentView{
    struct Configuration: UIContentConfiguration {

        
        var text: String? = ""
        
        var onChange: (String) -> Void = {_ in}
        
        func makeContentView() -> UIView & UIContentView {
            TextFieldContentView(self)
        }
        
        func updated(for state: UIConfigurationState) -> TextFieldContentView.Configuration {
            return self
        }
        
    }
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    let textField = UITextField()
    override var intrinsicContentSize: CGSize{
        CGSize(width: 0, height: 44)
    }
    
    init(_ configuration: UIContentConfiguration){
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubView(textField,insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        textField.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        textField.clearButtonMode = .whileEditing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration : UIContentConfiguration){
        guard let configuration = configuration as? Configuration else { return }
        textField.text = configuration.text
    }
    
    @objc private func didChange(_ sender: UITextField){
        //通过configuration的block回调通知修改了textfield
        guard let configuration = configuration as? TextFieldContentView.Configuration else{return}
        configuration.onChange(textField.text ?? "")
    }
}


extension UICollectionViewListCell {
    func textFieldConfiguration() -> TextFieldContentView.Configuration{
        TextFieldContentView.Configuration()
    }
}
