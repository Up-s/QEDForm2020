//
//  BirthForm.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/17.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit
class BirthForm: Form {
  
  private let yearGuideTextField: GuideTextField
  private let monthGuideTextField: GuideTextField
  private let dayGuideTextField: GuideTextField
  
  init(year: String, month: String, day: String) {
    self.yearGuideTextField = GuideTextField(sub: year)
    self.monthGuideTextField = GuideTextField(sub: month)
    self.dayGuideTextField = GuideTextField(sub: day)
    super.init(frame: .zero)
    
    baseUI()
    constraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func baseUI() {
    self.targetTextField = yearGuideTextField
    
    [yearGuideTextField, monthGuideTextField, dayGuideTextField].forEach {
      $0.keyboardType = .numberPad
      $0.addTarget(self, action: #selector(checkInt(_:)), for: .editingDidEnd)
      $0.addTarget(self, action: #selector(nextFocused(_:)), for: .editingChanged)
      self.addSubview($0)
    }
  }
  
  @objc
  private func checkInt(_ sender: UITextField) {
    guard let text = sender.text, let _ = Int(text) else { return sender.text = nil }
  }
  
  @objc
  private func nextFocused(_ sender: UITextField) {
    guard let text = sender.text else { return }
    switch sender {
    case yearGuideTextField:
      let date = Date()
      let calendar = Calendar.current
      let components = calendar.dateComponents([.year], from: date)
      guard let currentYear = components.year else { return }
      
      guard text.count >= 4 else { return }
      guard let year = Int(text), year < currentYear else { return sender.text = nil }
      monthGuideTextField.becomeFirstResponder()
      
    case monthGuideTextField:
      guard text.count >= 2 else { return }
      guard let month = Int(text), month < 13 else { return sender.text = nil }
      dayGuideTextField.becomeFirstResponder()
      
    default:
      guard text.count >= 2 else { return }
      guard let day = Int(text), day < 32 else { return sender.text = nil }
      delegate?.nextFocus(tag: self.tag)
    }
  }
  
  private func constraint() {
    [yearGuideTextField, monthGuideTextField, dayGuideTextField].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Padding.topSpace).isActive = true
      $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Padding.bottomSpace).isActive = true
    }
    
    NSLayoutConstraint.activate([
      yearGuideTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Padding.inset),
      yearGuideTextField.widthAnchor.constraint(equalTo: dayGuideTextField.widthAnchor, multiplier: 1.5),
      
      monthGuideTextField.leadingAnchor.constraint(equalTo: yearGuideTextField.trailingAnchor, constant: Padding.itemToPadding),
      monthGuideTextField.widthAnchor.constraint(equalTo: dayGuideTextField.widthAnchor, multiplier: 1),
      
      dayGuideTextField.leadingAnchor.constraint(equalTo: monthGuideTextField.trailingAnchor, constant: Padding.itemToPadding),
      dayGuideTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Padding.inset)
    ])
  }
}
