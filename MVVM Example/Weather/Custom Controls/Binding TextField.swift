//
//  Binding TextField.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/06/02.
//

import UIKit

class BindingTextField:UITextField {
    
    var textChangeClosure:(String) -> () = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func bind(callBack:@escaping(String) -> ()) {
        self.textChangeClosure = callBack
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        if let text = textField.text {
            self.textChangeClosure(text)
        }
    }
}
