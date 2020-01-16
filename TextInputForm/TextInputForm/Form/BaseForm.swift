//
//  BaseForm.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/16.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

class BaseForm: UIView {
  
  private let titleLabel = UILabel()
  let textField = UITextField()
  private let guideLine = UILabel()
  
  init(title: String) {
    super.init(frame: .zero)
    
    titleLabel.text = title
    
    baseUI()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func baseUI() {
    self.layer.cornerRadius = 16
    self.backgroundColor = .white
    
    titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
    self.addSubview(titleLabel)
    
    self.addSubview(textField)
    
    guideLine.backgroundColor = .black
    self.addSubview(guideLine)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
    static let inset: CGFloat = 24
  }
  
  private func autoLayout() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Standard.inset).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Standard.inset).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Standard.inset).isActive = true
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Standard.inset).isActive = true
    textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Standard.inset).isActive = true
    textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Standard.inset).isActive = true
    
    guideLine.translatesAutoresizingMaskIntoConstraints = false
    guideLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 3).isActive = true
    guideLine.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
    guideLine.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
    guideLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Standard.inset).isActive = true
    guideLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
}
