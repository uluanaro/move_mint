//
//  ClaudeModels.swift
//  MoveMint
//
//  Created by uluana_roshina on 14.07.2026.
//
import Foundation

struct ClaudeRequest: Encodable {
    let model: String
    let max_tokens: Int
    let messages: [Message]
    
    struct Message: Encodable {
        let role: String
        let content: String
    }
}

struct ClaudeResponse: Decodable {
    let content: [Content]
    
    struct Content: Decodable {
        let type: String
        let text: String
    }
}
