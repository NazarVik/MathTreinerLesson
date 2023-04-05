//
//  ViewController.swift
//  MathTreinerLesson
//
//  Created by Виктор Назаров on 5.04.23.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multyply, divede
}

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        
    }
    // MARK: - Action
    @IBAction func buttonsAction(_ sender: UIButton) {
        print("button was pressed")
        
    }
    // MARK: - Methods
    private func configureButtons(){
        buttonsCollection.forEach{button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.5
            button.layer.shadowRadius = 2
            
        }
    }

}

