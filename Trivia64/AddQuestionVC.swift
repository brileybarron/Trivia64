//
//  AddQuestionVC.swift
//  Trivia64
//
//  Created by Briley Barron on 10/19/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import UIKit

class AddQuestionVC: UIViewController {
    var newTrivia: TriviaQuestion?
    
    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerAField: UITextField!
    @IBOutlet weak var answerBField: UITextField!
    @IBOutlet weak var answerCField: UITextField!
    @IBOutlet weak var answerDField: UITextField!
    @IBOutlet weak var userQuestionField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var correctAnswerSegmentedControl: UISegmentedControl!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindSegueToTriviaVC", sender: self)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard
            let question = userQuestionField.text, !question.isEmpty,
            let a = answerAField.text, !a.isEmpty,
            let b = answerBField.text, !b.isEmpty,
            let c = answerCField.text, !c.isEmpty,
            let d = answerDField.text, !d.isEmpty
        else{
            let errorAlert = UIAlertController(title: "Error", message: "Please fill all fields or press cancel to return to the main screen", preferredStyle: UIAlertController.Style.alert)
            
            let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {UIAlertAction in})
            errorAlert.addAction(dismissAction)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        newTrivia = TriviaQuestion(question: question, answers: [a, b, c, d], correctAnswerIndex: correctAnswerSegmentedControl.selectedSegmentIndex)
        self.performSegue(withIdentifier: "unwindSegueToTriviaVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationVC = segue.destination as? TriviaVC,
            let newTriviaQuestion = newTrivia
            else{return}
        destinationVC.questions.append(newTriviaQuestion)
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
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
