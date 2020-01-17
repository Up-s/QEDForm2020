//
//  BaseForm.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/16.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

class BaseForm: UIView {
  
  private let form: FormModel
  private var subLabelCentYAnchor: NSLayoutConstraint?
  
  private let subLabel = UILabel()
  let textField = UITextField()
  private let guideLine = UILabel()
  
  init(form: FormModel) {
    self.form = form
    super.init(frame: .zero)
    
    baseUI()
    constraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func guideLineColorChanged() {
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.guideLine.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    }
  }
  
  func subLabelAnimated(status: Bool) {
    let moveDistance: CGFloat = 24
    UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: { [weak self] in
      switch status {
      case true:
        self?.subLabelCentYAnchor?.constant = -moveDistance
        self?.subLabel.alpha = 1
      case false:
        self?.subLabelCentYAnchor?.constant = moveDistance
        self?.subLabel.alpha = 0
      }
      self?.layoutIfNeeded()
    })
  }
  
  private func baseUI() {
    self.backgroundColor = .white
    
    switch form.type {
    case .base(let tempType):
      switch tempType {
      case .email:
        textField.keyboardType = .emailAddress
      case .nomarl:
        textField.keyboardType = .default
      case .number:
        textField.keyboardType = .numberPad
      case .password:
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
      }
    default:
      break
    }
    textField.placeholder = form.title
    textField.autocapitalizationType = .none
    textField.font = UIFont.systemFont(ofSize: 25, weight: .light)
    let textFieldAttr = [NSAttributedString.Key.font: textField.font!]
    Padding.textFieldHeight = ("Test" as NSString).size(withAttributes: textFieldAttr).height
    self.addSubview(textField)
    
    subLabel.alpha = 0
    subLabel.text = form.subTitle
    subLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
    self.addSubview(subLabel)
    
    guideLine.backgroundColor = .black
    self.addSubview(guideLine)
  }
  
  private struct Padding {
    static let inset: CGFloat = 24
    static let topSpace: CGFloat = 36
    static let bottomSpace: CGFloat = 24
    
    static var textFieldHeight: CGFloat = 0
  }
  
  private func constraint() {
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.topAnchor.constraint(equalTo: self.topAnchor, constant: Padding.topSpace).isActive = true
    textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Padding.inset).isActive = true
    textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Padding.inset).isActive = true
    textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Padding.bottomSpace).isActive = true
    textField.heightAnchor.constraint(equalToConstant: Padding.textFieldHeight).isActive = true
    
    subLabel.translatesAutoresizingMaskIntoConstraints = false
    subLabelCentYAnchor = subLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
    subLabelCentYAnchor?.isActive = true
    subLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
    subLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
    
    guideLine.translatesAutoresizingMaskIntoConstraints = false
    guideLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 3).isActive = true
    guideLine.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
    guideLine.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
    guideLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
}
