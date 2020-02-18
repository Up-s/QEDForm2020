//
//  PickerForm.swift
//  QEDForm
//
//  Created by Lee on 2020/02/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class PickerForm: Form {
  
  private var subLabelCentYAnchor: NSLayoutConstraint?
  private let list = ["1", "2", "3"]
  
  private let subLabel = UILabel()
  private let indexPickerView = UIPickerView()
  
  init(sub: String?) {
    super.init(frame: .zero)
    
    subLabel.text = sub
    
    baseUI()
    constraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func baseUI() {
    subLabel.alpha = 0
    subLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
    self.addSubview(subLabel)
    
    indexPickerView.dataSource = self
    indexPickerView.delegate = self
    self.addSubview(indexPickerView)
  }
  
  private func constraint() {
    [subLabel, indexPickerView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Padding.inset).isActive = true
      $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Padding.inset).isActive = true
    }
    
    subLabelCentYAnchor = subLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    subLabelCentYAnchor?.isActive = true
    
    NSLayoutConstraint.activate([
      indexPickerView.topAnchor.constraint(equalTo: self.topAnchor, constant: Padding.topSpace),
      indexPickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Padding.bottomSpace),
      indexPickerView.heightAnchor.constraint(equalToConstant: 120)
    ])
  }
}

extension PickerForm: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    list.count + 2
  }
}

extension PickerForm: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch row {
    case 0: return "선택"
    case list.count + 1: return "기타"
    default: return "\(row)번"
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    delegate?.nextFocus(tag: row)
    
    let moveDistance: CGFloat = 48
    UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: { [weak self] in
      self?.subLabelCentYAnchor?.constant = -moveDistance
      self?.subLabel.alpha = 1
      self?.layoutIfNeeded()
    })
  }
}
