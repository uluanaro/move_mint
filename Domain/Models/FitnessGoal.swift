//
//  FitnessGoal.swift
//  MoveMint
//
//  Created by uluana_roshina on 13.07.2026.
//
import Foundation


enum FitnessGoal: String, CaseIterable, Identifiable {
    case muscleGain = "Набор массы"
    case weightLoss = "Похудение"
    case wellbeing = "Самочувствие"
    
    var id: String { rawValue }
}



