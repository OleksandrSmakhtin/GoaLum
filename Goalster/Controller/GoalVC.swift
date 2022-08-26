//
//  ViewController.swift
//  Goalster
//
//  Created by Саша Смахтин on 05.07.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var goals: [Goal] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    
    
    // making data to update
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects(){
        
        self.fetch { complete in
            if complete {
                // if there are alredy data we will show tableView
                if goals.count >= 1{
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
                
            }
        }
    }
    
    
    
    
    
    
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(viewControllerToPresent: createGoalVC)
        
    }
    
}



extension GoalVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count // rows depends from a data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else { return UITableViewCell()}
        
        // fill the cells with proper data
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        return cell
    }
    
    
    
    
    // adding the removing button on cell
    
    // can edit row set to true
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // what editing style?
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // add actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // add delete
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { rowAction, indexPath in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        // add set progress
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { rowAction, indexPath in
            self.setProgress(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        
        return [deleteAction, addAction]
    }
    
    
    
    
    
}



extension GoalVC {
    //setting progress
    
    func setProgress(atIndexPath indexPath: IndexPath ){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let chosenGoal = goals[indexPath.row ]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress += 1
             
        } else {
            return
        }
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Cannot increment")
        }
        
    }
    
    
    
    // removing data
    func removeGoal(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
        } catch {
            print("Cannot delete")
        }
    }
    
    
    
    
    
    
    
    
    
    // fetshing our data
    func fetch(completion: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        // Creating fetch request (ловим данні)
        
        //                 name of the type                    name of our core data entity
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        
        // correcting errors
        
        do {                //  returns an array of our data
                            // array creates on top
 // fill an array with data
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could not fetch")
            completion(false)
        }
        
        
    }
    
    
}
