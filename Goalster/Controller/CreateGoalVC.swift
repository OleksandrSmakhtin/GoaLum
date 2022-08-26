//
//  CreateGoalVC.swift
//  Goalster
//
//  Created by Саша Смахтин on 06.07.2022.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    // Prepare the data to pass in to the next VC
    var goalType: GoalType = .shortTerm
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        shortTermBtn.selectedColor()
        longTermBtn.deselectedColor()
        
        goalTextView.delegate = self
    }
    

    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.selectedColor()
        longTermBtn.deselectedColor()
    }
    
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.selectedColor()
        shortTermBtn.deselectedColor()
    }
    
    
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            guard let finishVC = storyboard?.instantiateViewController(withIdentifier: "FinishVC") as? FinishVC else {return}
            finishVC.initData(description: goalTextView.text, type: goalType)
            
            presentingViewController?.presentSecondaryDetail(viewControllerToPresent: finishVC)
        }
        
        
        
    }
    

    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    
    // Clear the text view when starts printing
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = UIColor.black
    }
    
    
}
