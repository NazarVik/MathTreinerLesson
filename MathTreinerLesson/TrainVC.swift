//
//  TrainVC.swift
//  MathTreinerLesson
//
//  Created by Виктор Назаров on 5.04.23.
//

import UIKit

final class TrainViewController : UIViewController {
    
@IBOutlet var buttonsCollection: [UIButton]!

    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configButtons()
        
    }
    
    
    private func configButtons(){
        buttonsCollection.forEach{button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 3)
            button.layer.shadowOpacity = 0.5
            button.layer.shadowRadius = 4
            
        }
    }
}

