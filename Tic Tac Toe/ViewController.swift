//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Costi Mihai on 04/06/19.
//  Copyright © 2019 Costi Mihai. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    var isPhonePlayer: Bool = false
    var phonesCells = [Int]()
    var playersCells = [Int]()
    var buttonsArray: [UIButton] = []
    var winner: String = ""
    var numberOfClicks: Int = 0
    var availableCells: [Int] = [1,2,3,4,5,6,7,8,9]
    var message: String = ""
    var dataToReceive: String = ""
    
    var phoneColor: UIColor = UIColor(red: 102/255, green: 250/255, blue: 51/255, alpha: 0.5)
    var playerColor: UIColor = UIColor(red: 32/255, green: 192/255, blue: 243/255, alpha: 0.5)
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    let winningPossibilities: [[Int]] = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsArray = [b1, b2, b3, b4, b5, b6, b7, b8, b9]
        nameLabel.text = dataToReceive
    }
    
    @IBAction func pressButton(_ sender: Any) {
        numberOfClicks += 1
        
        // player's chance
        let selectedButton = sender as! UIButton
        playGame(button: selectedButton)
        
        // check whether player is a winner
        if numberOfClicks >= 3 && winnerOfTheGame() == "player" {
            message = "Ai castigat."
            endGame()
        }
        else {
            // phone's chance
            let randomNumber = selectRandomNumber()!
            let computersButton = buttonsArray[randomNumber - 1]
            playGame(button: computersButton)
            
            // check whether phone is a winner
            if winnerOfTheGame() == "phone" {
                message = "Ai pierdut."
                endGame()
            }
        }
        
        if winnerOfTheGame() == "" && numberOfClicks == 4 {
            for i in availableCells {
                buttonsArray[i-1].isEnabled = false
            }
            message = "Egalitate."
            endGame()
        }
        
    }
    
    func playGame(button selectedButton: UIButton) {

        if isPhonePlayer {
            selectedButton.setTitle("O", for: UIControl.State.normal)
            selectedButton.backgroundColor = phoneColor
            phonesCells.append(selectedButton.tag)
            availableCells = availableCells.filter{ $0 != selectedButton.tag }
           
            isPhonePlayer = !isPhonePlayer
        } else {
            selectedButton.setTitle("X", for: UIControl.State.normal)
            selectedButton.backgroundColor = playerColor
            playersCells.append(selectedButton.tag)
            availableCells = availableCells.filter{ $0 != selectedButton.tag }
           
            isPhonePlayer = !isPhonePlayer
        }
        
        selectedButton.isEnabled = false
    }
    
    func selectRandomNumber() -> Int? {
        return availableCells.randomElement()
    }
    
    func winnerOfTheGame() -> String {
        for possibility in winningPossibilities {
            // check whether player is the winner
            let isPlayerWinner = containsNumbers(cellsArray: playersCells.sorted(), possibilityArray: possibility)
            if isPlayerWinner {
                winner = "player"
                break
            }
            
            // check whether phone is the winner
            let isPhoneWinner = containsNumbers(cellsArray: phonesCells.sorted(), possibilityArray: possibility)
            if isPhoneWinner {
                winner = "phone"
                break
            }
        }
        
        return winner
    }
    
    func containsNumbers(cellsArray: [Int], possibilityArray: [Int]) -> Bool {
        var isHaving = false
        
        for i in possibilityArray {
            isHaving = cellsArray.contains(i)
            
            if !isHaving {
                break
            }
        }
        
        return isHaving
    }
    
    func endGame() {
        displayWinner(message: message)
    }
    
    func gameOverAlertHandler(alert: UIAlertAction!) {
        restart()
    }
    func displayWinner(message: String) {
        let alert = UIAlertController(title: "Jocul s-a terminat.", message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: gameOverAlertHandler(alert:)))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func restartAction(_ sender: Any) {
        restart()
    }
    
    func restart() {
        initVars()
        
        for button in buttonsArray {
            button.setTitle("", for: UIControl.State.normal)
            button.isEnabled = true
            button.backgroundColor = UIColor.white
        }
    }
    
    func initVars() {
        isPhonePlayer = false
        phonesCells = []
        playersCells = []
        winner = ""
        message = ""
        numberOfClicks = 0
        availableCells = [1,2,3,4,5,6,7,8,9]
    }
}

