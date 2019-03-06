//
//  HomeVC.swift
//  SwfitDemo
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/25.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

import UIKit
class Vehicle {
  var numberOfWheels = 0
  var description: String {
    return "\(numberOfWheels) wheel(s)"
  }
}


class Customer {
  let name: String
  var card: CreditCard?
  init(name: String) {
    self.name = name
  }
  deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
  let number: UInt64
  unowned let customer: Customer
  init(number: UInt64, customer: Customer) {
    self.number = number
    self.customer = customer
  }
  deinit { print("Card #\(number) is being deinitialized") }
}

class Bicycle: Vehicle {
  var speed = 0
  override init() {
    super.init()
    numberOfWheels = 2
  }
}

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

  let num = 10

  struct Fahrenheiit {
    var temperature:Double
    init() {
      temperature = 32.0
    }
  }
  struct Student  {
    var name:String
    var height:Double
    var age:Int

    init(tempName:String ,tempHeight:Double,tempAge:Int) {
      name = tempName
      height = tempHeight
      age = tempAge
    }
  }

  struct Color {
    var colors:[Bool] = {
      var textColors = [Bool]()
      var isBlack:Bool = false
      for  i in 0...10 {
        for  j in 0...100 {
          textColors.append(isBlack)
          isBlack = !isBlack
        }
        isBlack = !isBlack
      }
      return textColors;
    }()

  }
  var listView:UITableView?
  var datas = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.packageData()
      self.addListView()

//    let  resut:DataRequest =  AF.request(NSURL(string: "http://testm.gzl.cn/app-web/native/travel/productDetail.json"), method: HTTPMethod.post, parameters: ["pdId":""], encoding: URLEncoding.default , headers: nil, interceptor: RequestInterceptor?)


    }


 // MARK: - 测试结构体
  private func testStruct(){


    let student = Student(tempName: "小明", tempHeight: 1.78, tempAge: 25)

    SCLAlertView().showInfo(student.name, subTitle: "姓名:" + student.name + "\n" + "年龄:" + String(student.age) + "\n"  + "身高:" + String(student.height))


    print(Color().colors.description + String(Color().colors.count) + "tiao")
  }

  // MARK: - 打包数据
  func packageData()  {
    for test in 0...1000 {
      var text = ""
      switch test % num {
      case 0:
        text = "showWait"
      case 1:
        text = "showWarning"
      case 2:
        text = "showNotice"
      case 3:
        text = "showEdit"
      case 4:
        text = "showSuccess"
      case 5:
        text = "showInfo"
      case 6:
        text = "showError"
      case 7:
        text = "showTitle"
      case 8:
        text = "showCustom"
      case 9:
        text = "测试结构体"
      default:
        text = "showInfo ------"
      }
      self.datas.append(text + "-----" + "测试用例" + "-----" + String(test))
    }
  }

// MARK: - 添加列表试图
  func addListView()  {
    listView = UITableView()
    view.addSubview(listView!)
    listView?.snp.makeConstraints({ (make) in
      make.top.equalTo(64)
      make.bottom.left.right.equalTo(view)
    })
    listView?.backgroundColor = UIColor(white: 0.7, alpha: 0.1)
    listView?.delegate = self
    listView?.dataSource = self

    typealias textTest = ()->Void





  }

  // MARK: - UITableView  数据源 代理

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.datas.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self)) ?? UITableViewCell()
    cell.textLabel?.text = (self.datas[indexPath.row])
    cell.textLabel?.textColor = TourGuideAssistantVC.getColorValue()
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let text:String = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "hello world"

    switch indexPath.row % num {
    case 0:
      SCLAlertView().showWait("", subTitle:text)
    case 1:
      SCLAlertView().showWarning("", subTitle:text)
    case 2:
      SCLAlertView().showNotice("", subTitle:text)
    case 3:
      SCLAlertView().showEdit("", subTitle: text)
    case 4:
      SCLAlertView().showSuccess("", subTitle:text)
    case 5:
      SCLAlertView().showInfo("", subTitle:text)
    case 6:
      SCLAlertView().showError("", subTitle:text)
    case 7:
      SCLAlertView().showTitle("", subTitle:text, style: SCLAlertViewStyle.success)
    case 8:
      SCLAlertView().showCustom("", subTitle: text, color: UIColor.red, icon: UIImage())
    case 9:
      testStruct()
    default:
      SCLAlertView().showInfo("", subTitle:text)
    }
  }


}
