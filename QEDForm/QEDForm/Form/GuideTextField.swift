//
//  GuideTextField.swift
//  QEDForm
//
//  Created by Lee on 2020/02/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class GuideTextField: UITextField {
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }
  
  lazy var height: CGFloat = {
    self.font = UIFont.systemFont(ofSize: 25, weight: .light)
    let textFieldAttr = [NSAttributedString.Key.font: self.font!]
    return ("Test" as NSString).size(withAttributes: textFieldAttr).height
  }()
  private var subLabelCentYAnchor: NSLayoutConstraint?
  
  private let subLabel = UILabel()
  private let guidLine = UIView()
  
  init(sub: String?) {
    super.init(frame: .zero)
    
    self.placeholder = sub
    self.autocapitalizationType = .none
    self.addTarget(self, action: #selector(subLabelAnimated), for: .editingChanged)
    self.addTarget(self, action: #selector(guideLineColorChange), for: .editingChanged)
    
    subLabel.text = sub
    subLabel.alpha = 0
    subLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
    
    guidLine.backgroundColor = .red
    
    [subLabel, guidLine].forEach {
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    subLabelCentYAnchor = subLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    subLabelCentYAnchor?.isActive = true
    
    NSLayoutConstraint.activate([
      guidLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
      guidLine.heightAnchor.constraint(equalToConstant: 3)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc
  private func subLabelAnimated() {
    let moveDistance: CGFloat = 24
    UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: { [weak self] in
      self?.subLabelCentYAnchor?.constant = -moveDistance
      self?.subLabel.alpha = 1
      self?.layoutIfNeeded()
    })
  }
  
  @objc
  func guideLineColorChange(_ sender: UITextField) {
    guard let text = sender.text else { return }
    UIView.animate(withDuration: 0.4) { [weak self] in
      self?.guidLine.backgroundColor = text.isEmpty ? .red : #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
  }
}
