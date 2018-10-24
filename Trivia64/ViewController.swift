//
//  ViewController.swift
//  Trivia64
//
//  Created by Briley Barron on 10/18/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import UIKit

class TriviaVC: UIViewController {
    var questions = [TriviaQuestion]()
    var newQuestion: TriviaQuestion?
    var currentIndex: Int!
    var questionsPlaceholder = [TriviaQuestion]()
    var score = 0 {
        didSet {
            scoreBoard.text = "\(score) Points"
        }
    }
    
    var currentQuestion: TriviaQuestion! {
        didSet {
            if let currentQuestion = currentQuestion {
                question.text = currentQuestion.question
                answerA.setTitle(currentQuestion.answers[0], for: .normal)
                answerB.setTitle(currentQuestion.answers[1], for: .normal)
                answerC.setTitle(currentQuestion.answers[2], for: .normal)
                AnswerD.setTitle(currentQuestion.answers[3], for: .normal)
                setNewColor()
            }
        }
    }
    
    //MARK: Outlets
    @IBOutlet weak var scoreBoard: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var addQuestionButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var AnswerD: UIButton!
    
    //MARK: Actions
    @IBAction func unwindToTriviaVC (segue: UIStoryboardSegue) {}
    
    func populateQuestions () {
        let question1 = TriviaQuestion(question: "What is the strike note of the Liberty Bell?", answers: ["Middle C", "B", "G Sharp", "E Flat"], correctAnswerIndex: 3)
        let question2 = TriviaQuestion(question: "What is the only flag in the United States that does not have a rectagular flag?", answers: ["Kentucky", "Ohio", "Wyoming", "Maine"], correctAnswerIndex: 1)
        let question3 = TriviaQuestion(question: "What was the shortest war in the history of the World?", answers: ["Anglo-Zanzibar", "Seven Days War", "World War II", "Hundred Years War"], correctAnswerIndex: 0)
        let question4 = TriviaQuestion(question: "How was Portland, Oregon's name initialized?", answers: ["Poker", "Coin-Toss", "Football Game", "Go-Fish"], correctAnswerIndex: 1)
        let question5 = TriviaQuestion(question: "What is it called when a tune gets stuck in your head?", answers: ["Manamana", "Wonder-Waffle", "Earworm", "Nightcrawler"], correctAnswerIndex: 2)
        questions = [question1, question2, question3, question4, question5]
    }
    
    
    let backroundColors = [
        UIColor(red: 206/255, green:24/255, blue: 3/255, alpha: 1.0),
        UIColor(red: 216/255, green:109/255, blue:0/255, alpha: 1.0),
        UIColor(red: 231/255, green:163/255, blue:0/255, alpha: 1.0),
        UIColor(red: 141/255, green:101/255, blue:87/255, alpha: 1.0)]
    
    func setNewColor() {
        let randomNumber = Int.random(in: 1...100)
        let randomColorA = backroundColors[randomNumber % 4]
        let randomColorB = backroundColors[(randomNumber + 2 ) % 4]
        let randomColorC = backroundColors[(randomNumber + 3 ) % 4]
        let randomColorD = backroundColors[(randomNumber + 1 ) % 4]
        
        answerA.backgroundColor = randomColorA
        answerB.backgroundColor = randomColorB
        answerC.backgroundColor = randomColorC
        AnswerD.backgroundColor = randomColorD
        
    }
    
    func getNewQuestion() {
        if questions.count > 0 {
            currentIndex = Int.random(in: 0..<questions.count)
            currentQuestion = questions[currentIndex]
        } else {
            //this will be the game over
            showGameOver()
        }
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        print(sender.tag)
        if sender.tag == currentQuestion.correctAnswerIndex {
            //correct
            showCorrectAnswerAlert()
            score += 1
            // need to fill up showCorrectAnswerAlert
        } else {
            //incorrect
            showIncorrectAnswerAlert()
        }
    }
    
    func showGameOver () {
        let gameOverAlert = UIAlertController(title: "Trivia Results", message: "Game Over! You answered \(score) out of \(questionsPlaceholder.count) correctly.", preferredStyle: UIAlertController.Style.actionSheet)
        
        let okAction = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default) {UIAlertAction in
            self.resetGame()
        }
        gameOverAlert.addAction(okAction)
        self.present(gameOverAlert, animated: true, completion: nil)
        
    }
    
    
    func resetGame () {
        //need to call this everytime a new question is added and everytime the reset button is pushed
        score = 0
        if !questions.isEmpty {
            questionsPlaceholder.append(contentsOf: questions)
        }
        questions = questionsPlaceholder
        questionsPlaceholder.removeAll()
        getNewQuestion()
    }
    
    func showCorrectAnswerAlert () {
        let correctAlert = UIAlertController(title: "Correct", message: "You answered correctly.  Great job!", preferredStyle: UIAlertController.Style.actionSheet)
        
        let okAction = UIAlertAction(title: "Thank You", style: UIAlertAction.Style.default) {UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        correctAlert.addAction(okAction)
        self.present(correctAlert, animated: true, completion: nil)
    }
    
    func showIncorrectAnswerAlert () {
        let incorrectAlert = UIAlertController(title: "Wrong", message: "You answered incorrectly.  The correct answer was \(currentQuestion.correctAnswer)!", preferredStyle: UIAlertController.Style.actionSheet)
        
        let okAction = UIAlertAction(title: "Thank You", style: UIAlertAction.Style.default) {UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        incorrectAlert.addAction(okAction)
        self.present(incorrectAlert, animated: true, completion: nil)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        resetGame()
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateQuestions()
        getNewQuestion()
        setNewColor()
    }


}

