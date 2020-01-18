//
//  TextForm.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/16.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

class TextForm: Form {
  
  private let keyBoardType: KeyBoardType
  
  private let guidTextField: GuideTextField
  
  init(sub: String, keyBoardType: KeyBoardType) {
    self.guidTextField = GuideTextField(sub: sub)
    self.keyBoardType = keyBoardType
    super.init(frame: .zero)
    
    baseUI()
    constraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func baseUI() {
    self.backgroundColor = .white
    self.targetTextField = guidTextField
    
    switch keyBoardType {
    case .email:
      guidTextField.keyboardType = .emailAddress
    case .nomarl:
      guidTextField.keyboardType = .default
    case .number:
      guidTextField.keyboardType = .asciiCapableNumberPad
    case .password:
      guidTextField.isSecureTextEntry = true
      guidTextField.keyboardType = .default
    }
    guidTextField.addTarget(self, action: #selector(nextFocused(_:)), for: .editingDidEndOnExit)
    self.addSubview(guidTextField)
  }
  
  @objc
  private func nextFocused(_ sender: UITextField) {
    guard let text = sender.text, !text.isEmpty else { return }
    delegate?.nextFocus(tag: self.tag)
  }
  
  private func constraint() {
    guidTextField.translatesAutoresizingMaskIntoConstraints = false
    guidTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: Padding.topSpace).isActive = true
    guidTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Padding.inset).isActive = true
    guidTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Padding.inset).isActive = true
    guidTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Padding.bottomSpace).isActive = true
    guidTextField.heightAnchor.constraint(equalToConstant: guidTextField.height).isActive = true
  }
}

