//
//  BirthForm.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/17.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

class BirthForm: UIView {
  
  private var currentYear: Int?
  
  let yearGuideTextField: GuideTextField
  private let monthGuideTextField: GuideTextField
  let dayGuideTextField: GuideTextField
  
  init(year: String, month: String, day: String) {
    self.yearGuideTextField = GuideTextField(sub: year)
    self.monthGuideTextField = GuideTextField(sub: month)
    self.dayGuideTextField = GuideTextField(sub: day)
    super.init(frame: .zero)
    
    let date = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year], from: date)
    currentYear = components.year
    
    baseUI()
    constraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func baseUI() {
    yearGuideTextField.keyboardType = .numberPad
    yearGuideTextField.addTarget(self, action: #selector(nextFocused(_:)), for: .editingChanged)
    self.addSubview(yearGuideTextField)
    
    monthGuideTextField.keyboardType = .numberPad
    monthGuideTextField.addTarget(self, action: #selector(nextFocused(_:)), for: .editingChanged)
    monthGuideTextField.addTarget(self, action: #selector(checkInt(_:)), for: .editingDidEnd)
    self.addSubview(monthGuideTextField)
    
    dayGuideTextField.keyboardType = .numberPad
    self.addSubview(dayGuideTextField)
  }
  
  @objc
  private func checkInt(_ sender: UITextField) {
    guard let text = sender.text, let _ = Int(text) else { return sender.text = nil }
  }
  
  @objc
  private func nextFocused(_ sender: UITextField) {
    guard let text = sender.text, let currentYear = self.currentYear else { return }
    switch sender {
    case yearGuideTextField:
      guard text.count >= 4 else { return }
      guard let year = Int(text), year < currentYear else { return sender.text = nil }
      monthGuideTextField.becomeFirstResponder()
      
    default:
      guard text.count >= 2 else { return }
      guard let month = Int(text), month < 13 else { return sender.text = nil }
      dayGuideTextField.becomeFirstResponder()
    }
  }
  
  private struct Padding {
    static let inset: CGFloat = 0
    static let itemToPadding: CGFloat = 24
    static let topSpace: CGFloat = 32
    static let bottomSpace: CGFloat = 24
  }
  
  private func constraint() {
    yearGuideTextField.translatesAutoresizingMaskIntoConstraints = false
    yearGuideTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: Padding.topSpace).isActive = true
    yearGuideTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Padding.inset).isActive = true
    yearGuideTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Padding.bottomSpace).isActive = true
    yearGuideTextField.widthAnchor.constraint(equalTo: dayGuideTextField.widthAnchor, multiplier: 1.5).isActive = true
    
    monthGuideTextField.translatesAutoresizingMaskIntoConstraints = false
    monthGuideTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: Padding.topSpace).isActive = true
    monthGuideTextField.leadingAnchor.constraint(equalTo: yearGuideTextField.trailingAnchor, constant: Padding.itemToPadding).isActive = true
    monthGuideTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Padding.bottomSpace).isActive = true
    monthGuideTextField.widthAnchor.constraint(equalTo: dayGuideTextField.widthAnchor, multiplier: 1).isActive = true
    
    dayGuideTextField.translatesAutoresizingMaskIntoConstraints = false
    dayGuideTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: Padding.topSpace).isActive = true
    dayGuideTextField.leadingAnchor.constraint(equalTo: monthGuideTextField.trailingAnchor, constant: Padding.itemToPadding).isActive = true
    dayGuideTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Padding.inset).isActive = true
    dayGuideTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Padding.bottomSpace).isActive = true
  }
  
}
