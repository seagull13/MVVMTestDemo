//
//  MineInformationVC.swift
//  SwfitDemo
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/27.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

import UIKit

class MineInformationVC: ButtonBarPagerTabStripViewController {
  var isReload = false
    override func viewDidLoad() {
        super.viewDidLoad()
      buttonBarView.selectedBar.backgroundColor = .orange
      buttonBarView.backgroundColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
        // Do any additional setup after loading the view.
    }

  // MARK: - PagerTabStripDataSource
  override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    let child_1 = TeamMessageVC()
    let child_2 = TeamMessageVC()
    let child_3 = TeamMessageVC()


    guard isReload else {
      return [child_1, child_2, child_3]
    }

    var childViewControllers = [child_1, child_2]

    for index in childViewControllers.indices {
      let nElements = childViewControllers.count - index
      let n = (Int(arc4random()) % nElements) + index
      if n != index {
        childViewControllers.swapAt(index, n)
      }
    }
    let nItems = 1 + (arc4random() % 8)
    return Array(childViewControllers.prefix(Int(nItems)))
  }

  override func reloadPagerTabStripView() {
    isReload = true
    if arc4random() % 2 == 0 {
      pagerBehaviour = .progressive(skipIntermediateViewControllers: arc4random() % 2 == 0, elasticIndicatorLimit: arc4random() % 2 == 0 )
    } else {
      pagerBehaviour = .common(skipIntermediateViewControllers: arc4random() % 2 == 0)
    }
    super.reloadPagerTabStripView()
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
