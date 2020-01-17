//
//  TextForm.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/16.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

class TextForm: UIView {
  
  private let keyBoardType: KeyBoardType
  private var subLabelCentYAnchor: NSLayoutConstraint?
  
  let guidTextField: GuideTextField
  
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
    
    self.addSubview(guidTextField)
  }
  
  private struct Padding {
    static let inset: CGFloat = 0
    static let topSpace: CGFloat = 32
    static let bottomSpace: CGFloat = 24
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
