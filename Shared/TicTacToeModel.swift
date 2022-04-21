//
//  TicTacToeModel.swift
//  TickityTacTow
//
//  Created by Jared Davidson on 5/28/21.
//

import Foundation
import SwiftUI

class TicTacToeModel : ObservableObject {
    @Published var squares = [Square]()
    
    init() {
        for _ in 0...8 {
            squares.append(Square(status: .empty))
        }
    }
    
    // makes all squares empty
    func resetGame() {
        for i in 0...8 {
            squares[i].squareStatus = .empty
        }
    }
    
    // stores whether or not the game is over
    var gameOver : (SquareStatus, Bool) {
        get {
            if thereIsAWinner != .empty {
                return (thereIsAWinner, true)
            } else {
                for i in 0...8 {
                    if squares[i].squareStatus == .empty {
                        return(.empty, false)
                    }
                }
                return (.empty, true)
            }
        }
    }
    
    // checks if any win condition is reached
    private var thereIsAWinner: SquareStatus {
        get {
            if let check = self.checkIndexes([0, 1, 2]) {
                return check
            } else  if let check = self.checkIndexes([3, 4, 5]) {
                return check
            }  else  if let check = self.checkIndexes([6, 7, 8]) {
                return check
            }  else  if let check = self.checkIndexes([0, 3, 6]) {
                return check
            }  else  if let check = self.checkIndexes([1, 4, 7]) {
                return check
            }  else  if let check = self.checkIndexes([2, 5, 8]) {
                return check
            }  else  if let check = self.checkIndexes([0, 4, 8]) {
                return check
            }  else  if let check = self.checkIndexes([2, 4, 6]) {
                return check
            }
            return .empty
        }
    }
    
    // win checking logic
    private func checkIndexes(_ indexes : [Int]) -> SquareStatus? {
        var homeCounter : Int = 0
        var visitorCounter : Int = 0
        for index in indexes {
            let square = squares[index]
            if square.squareStatus == .home {
                homeCounter += 1
            } else if square.squareStatus == .visitor {
                visitorCounter += 1
            }
        }
        if homeCounter == 3 {
            return .home
        } else if visitorCounter == 3 {
            return .visitor
        }
        return nil
    }
    
    // randomized ai moves
    private func moveAI() {
        var index = Int.random(in: 0...8)
        while makeMove(index: index, player: .visitor) == false && gameOver.1 == false {
            index = Int.random(in: 0...8)
        }
    }
    
    // user input handling
    func makeMove(index: Int, player: SquareStatus) -> Bool {
        if squares[index].squareStatus == .empty {
            squares[index].squareStatus = player
            if player == .home {
                moveAI()
            }
            return true
        }
        return false
    }
    
}
