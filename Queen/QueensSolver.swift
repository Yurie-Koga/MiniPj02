//
//  QueensSolver.swift
//  SwiftAGDS
//
//  Created by Derrick Park on 2019-03-13.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

/// Write a function solveQueens that accepts a Board as a parameter
/// and tries to place 8 queens on it safely.
///
/// - Your method should stop exploring if it finds a solution
/// - You are allowed to change the function header (args or return type)
/// - Your total recursive calls should not exceed 120 times.

var posCount = 0
var recCount = 0
func solveQueens(board: inout Board) {
    rec(board: &board)
    print("Total possibilities: \(posCount)\n")
    
    recCount = 0
    let _ = rec_singlePos(board: &board)
    print("Number of recursive calls: \(recCount)\n")
}

func rec(board: inout Board, stRow: Int = 0, stCol: Int = 0) {
    for col in stCol..<board.size {
        if board.isSafe(row: stRow, col: col) {
            board.place(row: stRow, col: col)
            checkResult(board: &board)
            rec(board: &board, stRow: stRow, stCol: col)
            board.remove(row: stRow, col: col)
        }
    }
    
    for row in stRow + 1 ..< board.size {
        for col in 0..<board.size {
            if board.isSafe(row: row, col: col) {
                board.place(row: row, col: col)
                checkResult(board: &board)
                rec(board: &board, stRow: row, stCol: col)
                board.remove(row: row, col: col)
            }
        }
    }
}

func checkResult(board: inout Board) {
    if board.placedCount == board.size {
        print(board.description)
        posCount += 1
    }
}

func rec_singlePos(board: inout Board) -> Bool {
    recCount += 1
    
    for row in 0..<board.size {
        for col in 0..<board.size {
            if board.isSafe(row: row, col: col) {
                board.place(row: row, col: col)
                if board.placedCount == board.size {
                    print(board.description)
                    return true
                }
                if !rec_singlePos(board: &board) {
                    board.remove(row: row, col: col)
                }
            }
        }
        if !board.isPlacedInRow(row: row) {
            return false
        }
    }
    return true
}

