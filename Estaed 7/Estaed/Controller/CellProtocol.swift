//
//  CellProtocol.swift
//  Estaed
//
//  Created by arwa balawi on 17/05/1443 AH.
//


//MARK:-       1 cell خطوات تفعيل زر بوتون في
// لو ابي اربط زر بوتون في cell بواجهه أخرى صعب أستخدم التقليديه اللي عن طريق فنكشن لذلك بسوي ملف جديد وأحط بداخله بروتوكول نسخ لصق ثم أنتقل إلى كلاس الموجود فيه التيبل فيو
import Foundation
protocol MyCellDelegate : AnyObject {
  
  
    func didPressButton(_ tag: Int)
}
