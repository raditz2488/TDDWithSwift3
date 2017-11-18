//
//  ViewController.swift
//  FirstDemo
//
//  Created by Rohan Bhale on 08/05/17.
//  Copyright © 2017 RB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfVowels(in string: String) -> Int {
        let vowels : [Character] = ["a", "e", "i", "o", "u",
                                    "A", "E", "I", "O", "U"];
        
        return string.characters.reduce(0) {
            //Here $0 will be previous result and $1 will be the character that we test
            $0 + (vowels.contains($1) ? 1 : 0)
        }
    }
    
    func makeHeadline(from string: String) -> String {
        let words = string.components(separatedBy: " ")
        
        let headlineWords = words.map{ word -> String in
            var mutableWord = word
            let firstCharacter = mutableWord.remove(at: mutableWord.startIndex)
            return String(firstCharacter).uppercased() + mutableWord
         }
        
        return headlineWords.joined(separator:" ")
    }
    
}

