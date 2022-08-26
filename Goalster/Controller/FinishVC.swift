//
//  FinishVC.swift
//  Goalster
//
//  Created by Саша Смахтин on 08.07.2022.
//

import UIKit
import CoreData





class FinishVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    
    @IBOutlet weak var pointsTextField: UITextField!
    
    
    // Catching data from CreateGoalVC
    
    var goalDecription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType){
        
        self.goalDecription = description
        self.goalType = type
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self
        
    }
    
    
    
    // When pressed we pass data to Core Date
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        if pointsTextField.text != nil {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
        
        
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    
    
    func save(completion: (_ finished: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDecription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        // Starting goal progress
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save \(error.localizedDescription)")
            completion(false)
        }
        
        
    }
    
    
}
