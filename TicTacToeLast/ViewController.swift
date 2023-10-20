//
//  ViewController.swift
//  TicTacToeLast
//
//  Created by STI Mac 9 on 2023-10-03.
//

import UIKit

class ViewController: UIViewController
{
    
    enum Turn {
        case O
        case X
    }

    @IBOutlet weak var turn: UILabel!
    
    // First row
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    // Second row
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    // Third row
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    // Keep track of whos turn it is
    var firstTurn = Turn.X
    var currentTurn = Turn.X
    
    // Declaration for O and X
    var O = "O"
    var X = "X"
    
    // Array for buttons
    var board = [UIButton]()
    
    // Score card
    var OScore = 0
    var XScore = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initBoard()
        
    }
    // Function for all buttons
    func initBoard()
    {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
      
    }
    // When the board (buttons) is tapped
    @IBAction func boardTapped(_ sender: UIButton)
    {
        addToBoard(sender)
        
        // Message if X wins
        if checkForWin(X)
        {
            // Adds score
            XScore += 1
            resultAlert(title: "X WINS!")
        }
        // Message if O wins
        if checkForWin(O)
        {
            //  Adds score
            OScore += 1
            resultAlert(title: "O WINS!")
        }
        
        // If the board is full
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
    } // func boardTapped ends
    

    // Check for victory
    func checkForWin(_ s :String) -> Bool
    {
        // Horizontal victory row 1
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
        {
            return true
        }
        // Horizontal victory row 2
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
        {
            return true
        }
        // Horizontal victory row 3
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        // Vertical victory row 1
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
        {
            return true
        }
        // Vertical victory row 2
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
        {
            return true
        }
        // Vertical victory row 3
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
        {
            return true
        }
        // Diagonal victory version 1
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
        {
            return true
        }
        // Diagonal victory version 2
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
        {
            return true
        }
            
        return false
    } // func checkForWin ends
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        
        return button.title(for: .normal) == symbol
    } // func thisSymbol ends
    
    // An alert to reset game
    func resultAlert(title: String)
    {
        _ = "\nO " + String(OScore) + "n\nX " + String(XScore)
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {(_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    } // func resultAlert ends
    
    // Enable reset board
    func resetBoard()
    {
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        // Either it's O's turn
        if (firstTurn == Turn.O)
        {
            firstTurn = Turn.X
            turn.text = X
        }
        // Or it's X's turn
        else if firstTurn == Turn.X
        {
            firstTurn = Turn.O
            turn.text = O
        }
        currentTurn = firstTurn
    }  // func ResetBoard ends
    
    // Check if empty space on the board
    func fullBoard() -> Bool
    {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    } // func fullBoard ends
    
    // Current turn
    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == Turn.O)
            {
                sender.setTitle(O, for: .normal)
                currentTurn = Turn.X
                turn.text = X
            }
            else if(currentTurn == Turn.X)
            {
                sender.setTitle(X, for: .normal)
                currentTurn = Turn.O
                turn.text = O
            }
            sender.isEnabled = false
        } // if-sats ends
    } // func addToBoard ends
}

