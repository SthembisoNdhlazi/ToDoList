//
//  CustomTableViewCell.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/22.
//

import UIKit
import Foundation
import CoreData

protocol isDone{
    func toggleIsDone(for cell:UITableViewCell)
}


class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var overdueLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var cellView: UIView!
    
    let dataProvider = DataProvider()
    
    var isDoneDelegate:isDone?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
    }
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
             cellView.layer.borderWidth = 0.5
        
            self.cellView.layer.masksToBounds = true
        cellView.layer.cornerRadius = cellView.frame.size.height/5
    cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cellView.layer.shadowRadius = 5
        cellView.layer.shadowOpacity = 1
        

    }
   
    
    func setUpCell(task: String, taskDescription: String,specifiedDate: String, isDone: Bool, model: NewTask){
        cellLabel.text = task
        descriptionLabel.text = taskDescription
        dateLabel.text = specifiedDate
        print("OVERDUE VALUE \(model.isOverdue)")
        
        
        if  model.date! < Date() {
            model.isOverdue = true
        }else{
            model.isOverdue = false
        }
        
        if  model.isOverdue == true {
            cellLabel.textColor = .red
            overdueLabel.text = "Overdue"
            overdueLabel.isHidden = false
            overdueLabel.textColor = .red
        }else{
            cellLabel.textColor = .black
            overdueLabel.isHidden = true
        }
        
        
        if isDone{
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            model.isOverdue = false
            cellLabel.textColor = .black
            overdueLabel.isHidden = true
           
        } else{
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
      
        
     
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func isCheckedTapped(_ sender: Any) {
        
        print("tapped")
        
        isDoneDelegate?.toggleIsDone(for: self)
        
        
        
    }
    
}
