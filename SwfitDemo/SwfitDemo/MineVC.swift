//
//  MineVC.swift
//  SwfitDemo
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/25.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

import UIKit
import Eureka
import SafariServices

class MineVC: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setMineVC()
      
        // Do any additional setup after loading the view.
    }

  func setMineVC()  {
    URLRow.defaultCellUpdate = { cell, row in cell.textField.textColor = .blue }
    LabelRow.defaultCellUpdate = { cell, row in cell.detailTextLabel?.textColor = .orange
      cell.detailTextLabel?.textAlignment = NSTextAlignment.right
    }
    CheckRow.defaultCellSetup = { cell, row in cell.tintColor = .orange }
    DateRow.defaultRowInitializer = { row in row.minimumDate = Date() }
    
    form +++
      
      Section()
      
      <<< LabelRow () {
        $0.title = "LabelRow"
        $0.value = "tap the row"
        }
        .onCellSelection { cell, row in
          row.title = (row.title ?? "") + " 🇺🇾 "
          row.reload() // or row.updateCell()
      }
      
      <<< DateRow() { $0.value = Date(); $0.title = "DateRow" }
      
      <<< CheckRow() {
        $0.title = "CheckRow"
        $0.value = true
      }
      
      <<< SwitchRow() {
        $0.title = "SwitchRow"
        $0.value = true
      }
      
      <<< SliderRow() {
        $0.title = "SliderRow"
        $0.value = 5.0
        }
        .cellSetup { cell, row in

      }
      
      <<< StepperRow() {
        $0.title = "StepperRow"
        $0.value = 1.0
      }
      
      +++ Section("SegmentedRow examples")
      
      <<< SegmentedRow<String>() { $0.options = ["One", "Two", "Three"] }
      

      
      <<< SegmentedRow<String>(){
        $0.title = "SegmentedRow"
        $0.options = ["One", "Two"]
        }.cellSetup { cell, row in
          cell.imageView?.image = UIImage(named: "plus_image")
      }
      
      <<< SegmentedRow<String>(){
        $0.options = ["One", "Two", "Three", "Four"]
        $0.value = "Three"
        }.cellSetup { cell, row in
          cell.imageView?.image = UIImage(named: "plus_image")
      }
      
      <<< SegmentedRow<UIImage>(){
        _ = ["selected", "plus_image", "unselected"]
//        $0.options = names.map { UIImage(named: $0)! }
        $0.value = $0.options?.last
      }
      
      +++ Section("Selectors Rows Examples")
      
      <<< ActionSheetRow<String>() {
        $0.title = "ActionSheetRow"
        $0.selectorTitle = "Your favourite player?"
        $0.options = ["Diego Forlán", "Edinson Cavani", "Diego Lugano", "Luis Suarez"]
        $0.value = "Luis Suarez"
        }
        .onPresent { from, to in
          to.popoverPresentationController?.permittedArrowDirections = .up
      }
      




    
    form +++ Section("Generic picker")
      
      <<< PickerRow<String>("Picker Row") { (row : PickerRow<String>) -> Void in
        
        row.options = []
        for i in 1...10{
          row.options.append("option \(i)")
        }
      }
      
      <<< PickerInputRow<String>("Picker Input Row"){
        $0.title = "Options"
        $0.options = []
        for i in 1...10{
          $0.options.append("option \(i)")
        }
        $0.value = $0.options.first
      }
      
      <<< DoublePickerInlineRow<String, Int>() {
        $0.title = "2 Component picker"
        $0.firstOptions = { return ["a", "b", "c"]}
        $0.secondOptions = { _ in return [1, 2, 3]}
      }
      <<< TriplePickerInputRow<String, String, Int>() {
        $0.firstOptions = { return ["a", "b", "c"]}
        $0.secondOptions = { return [$0, $0 + $0, $0 + "-" + $0, "asd"]}
        $0.thirdOptions = { _,_ in return [1, 2, 3]}
        $0.title = "3 Component picker"
      }
      
      +++ Section("个人l资料展示")


      <<< TextRow() {
        $0.title = "用户账号"
        $0.placeholder = "请输入你的用户账号"
      }
      <<< TextRow() {
        $0.title = "用户昵称"
        $0.placeholder = "请输入你的用户昵称"
      }
      <<< TextRow() {
        $0.title = "真实姓名"
        $0.placeholder = "请输入你的真实姓名"
      }
      <<< TextRow() {
        $0.title = "身份证号码"
        $0.placeholder = "请输入你的身份证号码"
        }.cellSetup({ (cell, row) in

        })

      <<< DecimalRow() {
        $0.title = "个人流动资金"
        $0.value = 5
        $0.formatter = DecimalFormatter()
        $0.useFormatterDuringInput = true
        //$0.useFormatterOnDidBeginEditing = true
        }.cellSetup { cell, _  in
          cell.textField.keyboardType = .numberPad
      }
      
      <<< URLRow() {
        $0.title = "个人网页"
        $0.value = URL(string: "http://www.gzl.cn")
        }.onCellSelection({ (cell, row) in
          let sfVC:SFSafariViewController = SFSafariViewController.init(url: row.value!)
          self.navigationController?.pushViewController(sfVC, animated: false)
        })
      
      <<< PhoneRow() {
        $0.title = "电话号码 (不可更改)"
        $0.value = "+020 00000008"
        $0.disabled = true
      }
      

      
      <<< PasswordRow() {
        $0.title = "密码"
        $0.value = "请输入你的密码"
      }
      
      <<< IntRow() {
        $0.title = "IntRow"
        $0.value = 2015
      }
      
      <<< EmailRow() {
        $0.title = "电子邮箱"
        $0.value = "1012665604@qq.com"
      }
      
      <<< TwitterRow() {
        $0.title = "TwitterRow"
        $0.value = "@xmartlabs"
      }
      
      <<< AccountRow() {
        $0.title = "AccountRow"
        $0.placeholder = "Placeholder"
      }
      
      <<< ZipCodeRow() {
        $0.title = "ZipCodeRow"
        $0.placeholder = "90210"
    }
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
