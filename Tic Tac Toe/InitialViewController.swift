//
//  InitialViewController.swift
//  Tic Tac Toe
//
//  Created by Costi Mihai on 16/04/2019.
//  Copyright © 2019 Costi Mihai. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var highScoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func startGame(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let nameText = nameField.text
        
                if segue.identifier == "View" {
        
                    //Initial your second view data control
                    let ExchangeViewData = segue.destination as! ViewController
        
                    //Send your data with segue
                    ExchangeViewData.dataToReceive = nameText as! String
                }
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
