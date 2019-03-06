//
//  TeamMessageVC.swift
//  SwfitDemo
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/27.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

import UIKit

protocol TeamMessageVCDelegate{
  func testDelegate()

}
protocol TeamMessageVProtocol{
  func testDelegate()




}
class TeamMessageVC: UIViewController,IndicatorInfoProvider {

  var delegate:TeamMessageVCDelegate? = nil
  var itemInfo: IndicatorInfo = "View"
    override func viewDidLoad() {
        super.viewDidLoad()
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = "XLPagerTabStrip"

      view.addSubview(label)
      view.backgroundColor = .white

      view.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
      view.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -50))
      label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelTap)))
      label.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return itemInfo
  }


  @objc func labelTap()  {
    if self.delegate != nil {

      self.delegate?.testDelegate()
      self.navigationController?.popViewController(animated: true)
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
