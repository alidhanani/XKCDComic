//
//  Response.swift
//  nextAuth
//
//  Created by Ali Dhanani on 14/12/2020.
//

import Foundation


struct Response: Decodable {
    let month: String
    let year: String
    let day: String
    let img: String
    let title: String
    let alt: String
    let transcript: String
    let safe_title: String
    let news: String
    let link: String
    let num: Int
}
