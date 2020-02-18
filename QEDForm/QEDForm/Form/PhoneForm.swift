//
//  PhoneForm.swift
//  QEDForm
//
//  Created by Lee on 2020/02/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class PhoneForm: Form {
  
  private let companyList = ["선택", "SKT", "KT", "LG"]
  private var companyIndex = 0
  
  private let guardLabel = UIView()
  private let companyPicker = UIPickerView()
  private let firstGuideTextField: GuideTextField
  private let secondGuideTextField: GuideTextField
  private let thirdGuideTextField: GuideTextField
  
  init(first: String) {
    self.firstGuideTextField = GuideTextField(sub: first)
    self.secondGuideTextField = GuideTextField(sub: nil)
    self.thirdGuideTextField = GuideTextField(sub: nil)
    super.init(frame: .zero)
    
    baseUI()
    constraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func baseUI() {
    self.nextTarget = firstGuideTextField
    
    self.addSubview(guardLabel)
    
    companyPicker.backgroundColor = .clear
    companyPicker.dataSource = self
    companyPicker.delegate = self
    self.addSubview(companyPicker)
    
    [firstGuideTextField, secondGuideTextField, thirdGuideTextField].forEach {
      $0.textAlignment = .center
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
    case firstGuideTextField:
      guard text.count >= 3 else { return }
      secondGuideTextField.becomeFirstResponder()
      
    case secondGuideTextField:
      guard text.count >= 4 else { return }
      thirdGuideTextField.becomeFirstResponder()
      
    default:
      guard text.count >= 4 else { return }
      guard companyIndex != 0 else {
        pickerColorAnimate()
        sender.text = nil
        return
      }
      delegate?.nextFocus(tag: self.tag)
    }
  }
  
  private func pickerColorAnimate() {
    guardLabel.backgroundColor = .red
    UIView.animate(withDuration: 1) { [weak self] in
      self?.guardLabel.backgroundColor = .white
    }
  }
  
  private func constraint() {
    companyPicker.translatesAutoresizingMaskIntoConstraints = false
    
    [guardLabel, firstGuideTextField, secondGuideTextField, thirdGuideTextField].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.centerYAnchor.constraint(equalTo: companyPicker.centerYAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      guardLabel.leadingAnchor.constraint(equalTo: companyPicker.leadingAnchor),
      guardLabel.trailingAnchor.constraint(equalTo: companyPicker.trailingAnchor),
      guardLabel.heightAnchor.constraint(equalToConstant: 24),
      
      companyPicker.topAnchor.constraint(equalTo: self.topAnchor),
      companyPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      companyPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      companyPicker.widthAnchor.constraint(equalTo: thirdGuideTextField.widthAnchor, multiplier: 0.8),
      companyPicker.heightAnchor.constraint(equalToConstant: 104),
      
      firstGuideTextField.leadingAnchor.constraint(equalTo: companyPicker.trailingAnchor, constant: Padding.itemToPadding),
      firstGuideTextField.widthAnchor.constraint(equalTo: thirdGuideTextField.widthAnchor, multiplier: 0.8),
      
      secondGuideTextField.leadingAnchor.constraint(equalTo: firstGuideTextField.trailingAnchor, constant: Padding.itemToPadding),
      secondGuideTextField.widthAnchor.constraint(equalTo: thirdGuideTextField.widthAnchor, multiplier: 1),
      
      thirdGuideTextField.leadingAnchor.constraint(equalTo: secondGuideTextField.trailingAnchor, constant: Padding.itemToPadding),
      thirdGuideTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Padding.inset)
    ])
  }
}

extension PhoneForm: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    companyList.count
  }
}

extension PhoneForm: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = UILabel()
    
    label.text = companyList[row]
    label.textAlignment = .center
    
    return label
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    companyIndex = row
  }
}
