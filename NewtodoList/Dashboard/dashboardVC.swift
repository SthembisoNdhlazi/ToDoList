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



class dashboardVC :  UIViewController, UIScrollViewDelegate {
    
    let dataProvider = DataProvider()
   
    @IBOutlet weak var schoolUIView: UIView!
    @IBOutlet weak var homeUIView: UIView!
    @IBOutlet weak var workUIView: UIView!
    @IBOutlet weak var dashboardScrollView: UIScrollView!
    
    @IBOutlet weak var personalUIView: UIView!
    @IBOutlet weak var overDueTasks: UIView!
    @IBOutlet weak var allTaskView: UIView!
    @IBOutlet weak var archiveUIView: UIView!
    @IBOutlet weak var progressBar: ProgressBarVC!
    
   var countFired: CGFloat = 0
    var donetotal: CGFloat = 0.0
    var donevalue: CGFloat = 0.0
    //---
    var overduetotal: CGFloat = 0.0
    var overduevalue: CGFloat = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Your Title"
        
        //done
        donevalue = CGFloat(dataProvider.models.filter{
            $0.done
        }.count)
        
        donetotal = CGFloat(dataProvider.models.count)
     
        overduevalue = CGFloat(dataProvider.models.filter{
            $0.isOverdue
        }.count)
        
        overduetotal = CGFloat(dataProvider.models.count)
        
       // progressBar.didUpdateProgress()
       print("wubba lubba dub dub \(progressBar.progressBarValue(value: donevalue, total: donetotal))")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        progressBar.didUpdateProgress()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardScrollView.contentSize = CGSize(width: 380, height: 1000)
        dataProvider.getAllItems()
        
        
        dashboardScrollView.delegate = self
        
       for item in self.dataProvider.models{
           if item.done == true{
            self.countFired += 1
            DispatchQueue.main.async {
                self.progressBar.doneprogress = min(0 * self.countFired, 1)
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
        
        //overdue tasks AKA urgent
        
        overDueTasks.layer.shadowOffset = CGSize(width: 10, height: 10)
        overDueTasks.layer.shadowRadius = 5
        overDueTasks.layer.shadowOpacity = 0.2
        overDueTasks.layer.cornerRadius = 15
        
        // work uiview
        workUIView.layer.shadowOffset = CGSize(width: 10, height: 10)
 
        workUIView.layer.shadowRadius = 5
        workUIView.layer.shadowOpacity = 0.2
        workUIView.layer.cornerRadius = 15
        
        //personal UIView
        personalUIView.layer.shadowOffset = CGSize(width: 10, height: 10)
 
        personalUIView.layer.shadowRadius = 5
        personalUIView.layer.shadowOpacity = 0.2
        personalUIView.layer.cornerRadius = 15
        
        //home UIview
        
        homeUIView.layer.shadowOffset = CGSize(width: 10, height: 10)
 
        homeUIView.layer.shadowRadius = 5
        
       homeUIView.layer.shadowOpacity = 0.2
        homeUIView.layer.cornerRadius = 15
        
        //school
        schoolUIView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        schoolUIView.layer.shadowRadius = 5
       schoolUIView.layer.shadowOpacity = 0.2
       schoolUIView.layer.cornerRadius = 15
    }
    
}




