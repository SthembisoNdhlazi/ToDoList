//
//  dashboardVC.swift
//  NewtodoList
//
//  Created by Bronwyn dos Santos on 2022/09/06.
//

import Foundation
import UIKit
import CoreData
import SwiftUI



class dashboardVC :  UIViewController{
    
    let dataProvider = DataProvider()
   
    
    @IBOutlet weak var overDueTasks: UIView!
    @IBOutlet weak var allTaskView: UIView!
    @IBOutlet weak var archiveUIView: UIView!
    @IBOutlet weak var progressBar: ProgressBarVC!
    
   var countFired: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.getAllItems()
        
       for item in self.dataProvider.models{
           if item.done == true{
            self.countFired += 1
            DispatchQueue.main.async {
                self.progressBar.progress = min(0 * self.countFired, 1)
                self.dataProvider.getAllItems()
                
            }
               
        }
      
    }
     
        //Customising the UIView SHortcuts
        
       // archive view
        
        
        archiveUIView.layer.shadowOffset = CGSize(width: 10, height: 10)
        archiveUIView.layer.shadowRadius = 5
        archiveUIView.layer.shadowOpacity = 0.2
        archiveUIView.layer.cornerRadius = 15
       //all task view
        
        allTaskView.layer.shadowOffset = CGSize(width: 10, height: 10)
        allTaskView.layer.shadowRadius = 5
        allTaskView.layer.shadowOpacity = 0.2
        allTaskView.layer.cornerRadius = 15
        
        //overdue tasks
        
        overDueTasks.layer.shadowOffset = CGSize(width: 10, height: 10)
        overDueTasks.layer.shadowRadius = 5
        overDueTasks.layer.shadowOpacity = 0.2
        overDueTasks.layer.cornerRadius = 15
        
    }
    
}




