//
//  DummyData.swift
//  QEDForm
//
//  Created by Lee on 2020/02/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation


var formData: [FormModel] = [
  FormModel(
    title: "이메일을 입력해주세요",
    type: FormType.text("Email", KeyBoardType.email)
  ),
  FormModel(
    title: "이름을 입력해주세요",
    type: FormType.text("Name", KeyBoardType.nomarl)
  ),
  FormModel(
    title: "전화번호를 입력해주세요",
    type: FormType.phone("Phone")
  ),
  FormModel(
    title: "닉네임을 입력해주세요",
    type: FormType.text("Nick Name", KeyBoardType.nomarl)
  ),
  FormModel(
    title: "취미를 적어주세요",
    type: FormType.text("Hobby", KeyBoardType.nomarl)
  ),
  FormModel(
    title: "생년월일을 입력해주세요",
    type: FormType.birth("Year", "Month", "Day")
  ),
  FormModel(
    title: "성별을 입력해주세요",
    type: FormType.gender("Gender")
  ),
  FormModel(
    title: "소속을 입력해주세요",
    type: FormType.text("Team", KeyBoardType.nomarl)
  ),
  FormModel(
    title: "비밀번호를 입력해주세요",
    type: FormType.text("Password", KeyBoardType.password)
  ),
  FormModel(
    title: "비밀번호를 재입력해주세요",
    type: FormType.text("Password", KeyBoardType.password)
  )
]
