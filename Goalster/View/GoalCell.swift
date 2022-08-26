//
//  GoalCell.swift
//  Goalster
//
//  Created by Саша Смахтин on 05.07.2022.
//

import UIKit

class GoalCell: UITableViewCell {

  
    @IBOutlet weak var goalDecriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    
    @IBOutlet weak var completionView: UIView!
    
    
    
    func configureCell(goal: Goal) {
        self.goalDecriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        
        // check the completion
        
        if goal.goalProgress == goal.goalCompletionValue{
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
            
    }
    
    
}
