//
//  DatePickerContentView.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/28.
//

import UIKit

class DatePickerContentView: UIView,UIContentView {
    
    struct Configuration: UIContentConfiguration{
        
        var date = Date.now
        
        var onChanged: (Date) -> Void = { _ in}
        
        func makeContentView() -> UIView & UIContentView {
            DatePickerContentView(self)
        }
        
        func updated(for state: UIConfigurationState) -> DatePickerContentView.Configuration {
            self
        }
        
        
    }
    
    var configuration: UIContentConfiguration{
        didSet{
            configure(configuration: configuration)
        }
    }
    
    let datePicker = UIDatePicker()
    
    init(_ configuration: UIContentConfiguration){
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubView(datePicker)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self, action: #selector(didPick(_:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration){
        guard let configuration = configuration as? Configuration else {return}
        datePicker.date = configuration.date
    }
    
    @objc private func didPick(_ sender: UIDatePicker){
        guard let configuration = configuration as? DatePickerContentView.Configuration else {return}
        configuration.onChanged(datePicker.date)
    }
}


extension UICollectionViewListCell {
    func datePickerConfiguration() -> DatePickerContentView.Configuration{
        DatePickerContentView.Configuration()
    }
}
