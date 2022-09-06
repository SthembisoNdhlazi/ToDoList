//
//  CustomTableViewCell.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/22.
//

import UIKit

protocol isDone{
    func toggleIsDone(for cell:UITableViewCell)
}


class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var cellView: UIView!
    
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
        
        //this works
//        self.cellView!.layer.shadowOffset = CGSize(width: 3, height: 2)
//        self.cellView!.layer.shadowColor = UIColor.black.cgColor
//        self.cellView!.layer.shadowRadius = 4
//        self.cellView!.layer.shadowOpacity = 0.50
//        self.cellView!.layer.masksToBounds = false;
//        self.cellView!.clipsToBounds = false;
    }
   
    
    func setUpCell(task: String, taskDescription: String,specifiedDate: String, isDone: Bool){
        cellLabel.text = task
        //descriptionLabel.text = taskDescription
        //dateLabel.text = specifiedDate
        
        if isDone{
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.black,renderingMode:.alwaysOriginal), for: .normal)
        } else{
            checkButton.setImage(UIImage(systemName: "circle")?.withTintColor(.black,renderingMode:.alwaysOriginal), for: .normal)
        }
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
      //  cellView.layer.borderWidth = 0.5
        
       // self.cellView.layer.masksToBounds = true
  
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