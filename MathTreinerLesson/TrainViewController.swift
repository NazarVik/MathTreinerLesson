//
//  TrainVC.swift
//  MathTreinerLesson
//
//  Created by Виктор Назаров on 5.04.23.
//

import UIKit

final class TrainViewController : UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    // MARK: - Properties
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    private var count: Int = 0 {
        didSet {
            print("Count :\(count)")
        }
    }
    
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add: sign = "+"
            case .subtract: sign = "-"
            case .multyply: sign = "*"
            case .divide: sign = "/"
            }
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multyply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
   
    // Mark: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureQuestion()
        configButtons()
        
    }
    
    //Mark: - Actions
    
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    // Mark: - methods
    
    private func configButtons(){
        let buttonsArray = [leftButton, rightButton]
        
        buttonsArray.forEach { button in
            button?.backgroundColor = .systemYellow
        }
        
        buttonsArray.forEach{button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 3)
            button?.layer.shadowOpacity = 0.5
            button?.layer.shadowRadius = 4
            
        }
        
        
        var randomAnswer: Int
        repeat {
            randomAnswer =  Int.random(in: (answer < 10 ? 0: answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
        let isRightButton = Bool.random()
                                      
        leftButton.setTitle(isRightButton ? String(randomAnswer): String(answer), for: .normal)
        rightButton.setTitle(isRightButton ? String(answer): String(randomAnswer), for: .normal)
    }
    
    private func configureQuestion () {
        firstNumber = Int.random(in: 1...99)
        secondNumber = type == .divide ? finderOfDivisor(number: firstNumber) : Int.random(in: 1...99)
        
        let question: String = "\(firstNumber) \(sign) \(secondNumber) = "
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        
        if isRightAnswer {
            let isSecondAttempt = rightButton.backgroundColor == .red || leftButton.backgroundColor == .red
            
            count += isSecondAttempt ? 0 : 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configButtons()
            }
        }
        
    }
    private func finderOfDivisor (number: Int) -> Int {
        var arr: [Int] = []
        for i in 2...number/2 {
            if number % i == 0 {
                arr.append(i)
            }
        }
        arr.append(number)
        return arr.randomElement()!
    }
}
