//
//  Data.swift
//  arabicLigatureWriting
//
//  Created by Mukhammad Miftakhul As'Adi on 19/04/23.
//

import Foundation

let text = [
    "Alwi loves to study Arabic as a way to open up a whole new world of communication and opportunities of Arabic as widely spoken language with deep cultural and historical significance. And just like you, Alwi is on a mission to  practice an essential skill to appreciate and participate in this beautiful art.",
    "TPQ is an initial of Islamic education institution for children in Indonesia. TPQ is an essential part of the Indonesian Islamic education system and is widely spread across the country that aim to provide basic education on Islamic teachings  including Quranic recitation, memorization, and understanding.",
    "But since when I study the basics, Alwi notice some huge problem: A difficulty in memorizing the letters due to their  unfamiliarity and similarity to each other. In addition, some different combinations of ligatures letters between the Hijaiyah, and the lack of learning media aids that can provide a visual illustrations to  write.  ",
    "This is why Alwi come to TPQ and all the children in Indonesia to start the fun journey of learning with Alwi, an Arabic Ligature Writing!"
]

let title = [
    "Hello",
    "TPQ?",
    "Facts",
    "Try!"
]

let hijaiyahLetters = ["ا", "ب", "ت", "ث", "ج", "ح", "خ", "د", "ذ", "ر", "ز", "س", "ش", "ص", "ض", "ط", "ظ", "ع", "غ", "ف", "ق", "ك", "ل", "م", "ن", "ه", "و", "ي"]

struct colors:Identifiable{
    var id:String = UUID().uuidString
    var color:String = ""
}

let colorPen = ["colorRedPen", "colorGreenPen", "colorBluePen", "colorPurplePen"]
