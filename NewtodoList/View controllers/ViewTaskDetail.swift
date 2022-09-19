//
//  ViewTaskDetail.swift
//  NewtodoList
//
//  Created by Bronwyn dos Santos on 2022/09/05.
//

import Foundation
import UIKit
import CoreData

class ViewTaskDetail: UIViewController {
    let dataProvider = DataProvider()
     
     var indexPath:Int?
     
     override func viewDidLoad() {
         super.viewDidLoad()

         dataProvider.getAllItems()
      
        
    
}
}
