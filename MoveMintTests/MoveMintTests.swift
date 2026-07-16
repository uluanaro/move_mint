//
//  MoveMintTests.swift
//  MoveMintTests
//
//  Created by uluana_roshina on 13.07.2026.
//

import Testing
@testable import MoveMint

struct MoveMintTests {

    @Test func manySteps_shortWorkout() {
        let planner = WorkoutPlanner()
        #expect(planner.duration(forSteps: 10000) == 15)
    }

    @Test func fewSteps_longWorkout() {
        let planner = WorkoutPlanner()
        #expect(planner.duration(forSteps: 2000) == 45)
    }

    @Test func mediumSteps_mediumWorkout() {
        let planner = WorkoutPlanner()
        #expect(planner.duration(forSteps: 5000) == 30)
    }
    @Test func exactly8000_shortWorkout() {
        let planner = WorkoutPlanner()
        #expect(planner.duration(forSteps: 8000) == 15)   // ровно на границе → короткая
    }

    @Test func exactly4000_mediumWorkout() {
        let planner = WorkoutPlanner()
        #expect(planner.duration(forSteps: 4000) == 30)   // ровно на границе → средняя
    }
    @Test func zeroSteps_longWorkout() {
        let planner = WorkoutPlanner()
        #expect(planner.duration(forSteps: 0) == 45)
    }
}
