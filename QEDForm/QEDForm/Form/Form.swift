//
//  Form.swift
//  QEDForm
//
//  Created by Lee on 2020/02/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol FormDelegate: AnyObject {
  func nextFocus(tag: Int)
}

class Form: UIView {
  
  weak var delegate: FormDelegate?
  
  var nextTarget: UIView?
  
  struct Padding {
    static let inset: CGFloat = 0
    static let itemToPadding: CGFloat = 24
    static let topSpace: CGFloat = 32
    static let bottomSpace: CGFloat = 24
  }
}
