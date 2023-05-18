//
//  ViewController.swift
//  MathTreinerLesson
//
//  Created by Виктор Назаров on 5.04.23.
//

import UIKit

enum MathTypes: Int, CaseIterable {
    case add, subtract, multiply, divide
    
    var key: String {
        switch self {
        case .add:
            return "addCount"
        case .subtract:
            return  "subtractCount"
        case .multiply:
            return  "multyplyCount"
        case .divide:
            return "divideCount"
        }
    }
}

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var subtractCountLabel: UILabel!
    @IBOutlet weak var addCountLabel: UILabel!
    @IBOutlet weak var multiplyCountLabel: UILabel!
    @IBOutlet weak var divideCountLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    // MARK: - Properties
    private var selectedType: MathTypes = .add
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        
        setCountLabels()
        
    }
    // MARK: - Action
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
        
    }
    @IBAction func clearAction(_ sender: Any) {
        MathTypes.allCases.forEach { type in
            let key = type.key
            UserDefaults.standard.removeObject(forKey: key)
            addCountLabel.text = "-"
            subtractCountLabel.text = "-"
            divideCountLabel.text = "-"
            multiplyCountLabel.text = "-"
        }
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        setCountLabels()
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func setCountLabels() {
        MathTypes.allCases.forEach { type in
            let key = type.key
            guard let count = UserDefaults.standard.object(forKey: key) as? Int else { return }
            
            switch type {
            case .add:
                addCountLabel.text = String(count)
            case .subtract:
                subtractCountLabel.text = String(count)
            case .multiply:
                multiplyCountLabel.text = String(count)
            case .divide:
                divideCountLabel.text = String(count)
            }
        }
    }
    
    
    private func configureButtons(){
        buttonsCollection.forEach{button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.5
            button.layer.shadowRadius = 2
            
        }
    }

}

