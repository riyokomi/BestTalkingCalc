//
//  ViewController.swift
//  BestTalkingCalc
//
//  Created by YuryG
//  Created between 2015-2016 for the Public Domain and as educational resource. 
//
//  Note: This project demo's only "Number Talking Features". 
//        All Caculator features are used from http://www.lynda.com/Swift-tutorials/Building-Note-Taking-App-iOS-9-Swift/
//        Thanks to Todd Perkins http://www.lynda.com/Todd-Perkins/118-1.html for Any/All Calculator functonality. 
//        Above video and this project, allow you to assemble a "Talking Calcuator"


import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {


    // MARK: - ViewController Class-Wide Variables
    // MARK: Speach Related
    let mySpeechSynth = AVSpeechSynthesizer()
    var myRate: Float = 0.50
    var myPitch: Float = 1.15
    var myVolume: Float = 0.92
    var currentLang = ("en-US", "English","United States","American English ","🇺🇸")
    
    
    // MARK: Calc Function Related
    // Calc Related  Based on Lynda.com Programming for Non-Programmers: iOS 8.  Thanks!
    var total: Double = 0  // Used To hold the numeric values entered
    var mode = 0   // stores mode button ( +, -, *, %.... )
    var valueString: String  = ""  // The String Version of Total
    var lastButtonWasMode:Bool = false  // Stores if mode button (above) was last button pressed
    
    //MARK:   UIPickerView Outlets
    @IBOutlet weak var myLangPicker: UIPickerView!
    
    //MARK:   Calc UI Outlets
    @IBOutlet weak var labelNumberDisplay: UILabel!

    //MARK:  Calc UI Actions
    @IBAction func numberButtonPressed(sender: UIButton) {
        
        // Save Data
        let myString =  sender.titleLabel?.text
        valueString = myString!
        
        
        //Calc Code
        if (valueString == "0" && myString == "0"){
            return
        }
        
        valueString = valueString.stringByAppendingString(myString!)
        
        // toInt()
        total = Double(valueString)!
        print("total is \(total)")
        
        // Go Do These:
        labelNumberDisplay.text = "\(total)"
        
        speakThisString(valueString)
        updateLabelDisplayingNumbers()
    }
    
    //MARK: - Calc Functions
    
    func updateLabelDisplayingNumbers(){
        labelNumberDisplay.text = valueString
    }

    
    //MARK: - Speaking Machine
    
    func speakThisString(passedString: String){
        
        mySpeechSynth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        let myUtterance = AVSpeechUtterance(string: passedString)
        myUtterance.rate = myRate
        myUtterance.pitchMultiplier = myPitch
        myUtterance.volume = myVolume
        myUtterance.voice = AVSpeechSynthesisVoice(language: currentLang.0)
        mySpeechSynth.speakUtterance(myUtterance)
        
        
        
    }
    @IBAction func lottoButtonPressed(sender: UIButton) {
       
        let randomNumberInLangArray = lottoSpin()
        myLangPicker.selectRow(randomNumberInLangArray, inComponent: 0, animated: true)
        currentLang = langCodeAll38[randomNumberInLangArray]

            print("lottoSpin:  \(lottoSpin())")
        
    
        
        speakThisString(currentLang.3)
        
    }
    
    //MARK: - ViewDidLoad & Memory Warning
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        let myWelcomeString = "🏪 🚶 🙄"
        labelNumberDisplay.text = myWelcomeString
       
//        myLangPicker.showsSelectionIndicator = true
        myLangPicker.selectRow(lottoSpin(), inComponent: 0, animated: true)
        
        
        print("lottoSpin:  \(lottoSpin())")
        speakThisString(myWelcomeString)
        
    }
    
    func lottoSpin()-> Int {
        let index = 1 + random() %  langCodeAll38.count
        return index
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Langugage UIPickerView Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langCodeAll38.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        pickerView.showsSelectionIndicator = true
        
        let myString = "\(langCodeAll38[row].4) \(langCodeAll38[row].3)"
        
        return myString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentLang = langCodeAll38[row]
        speakThisString(currentLang.3)
    }

    

    
    
    //MARK: - Data Model
    
    // current lang array has known typos, to fix in future.
    var langCodeAll38 = [
        ("en-US",  "English", "United States", "American English","🇺🇸"),
        ("ar-SA","Arabic","Saudi Arabia","العربية","🇸🇦"),
        ("cs-CZ", "Czech", "Czech Republic","český","🇨🇿"),
        ("da-DK", "Danish","Denmark","Dansk","🇩🇰"),
        ("de-DE",       "German", "Germany", "Deutsche","🇩🇪"),
        ("el-GR",      "Modern Greek",        "Greece","ελληνική","🇬🇷"),
        ("en-AU",     "English",     "Australia","Aussie","🇦🇺"),
        ("en-GB",     "English",     "United Kingdom", "Queen's English","🇬🇧"),
        ("en-IE",      "English",     "Ireland", "Gaeilge","🇮🇪"),
        ("en-ZA",       "English",     "South Africa", "South African English","🇿🇦"),
        ("es-ES",       "Spanish",     "Spain", "Español","🇪🇸"),
        ("es-MX",       "Spanish",     "Mexico", "Español de México","🇲🇽"),
        ("fi-FI",       "Finnish",     "Finland","Suomi","🇫🇮"),
        ("fr-CA",       "French",      "Canada","Français du Canada","🇨🇦" ),
        ("fr-FR",       "French",      "France", "Français","🇫🇷"),
        ("he-IL",       "Hebrew",      "Israel","עברית","🇮🇱"),
        ("hi-IN",       "Hindi",       "India", "हिन्दी","🇮🇳"),
        ("hu-HU",       "Hungarian",    "Hungary", "Magyar","🇭🇺"),
        ("id-ID",       "Indonesian",    "Indonesia","Bahasa Indonesia","🇮🇩"),
        ("it-IT",       "Italian",     "Italy", "Italiano","🇮🇹"),
        ("ja-JP",       "Japanese",     "Japan", "日本語","🇯🇵"),
        ("ko-KR",       "Korean",      "Republic of Korea", "한국어","🇰🇷"),
        ("nl-BE",       "Dutch",       "Belgium","Nederlandse","🇧🇪"),
        ("nl-NL",       "Dutch",       "Netherlands", "Nederlands","🇳🇱"),
        ("no-NO",       "Norwegian",    "Norway", "Norsk","🇳🇴"),
        ("pl-PL",       "Polish",      "Poland", "Polski","🇵🇱"),
        ("pt-BR",       "Portuguese",      "Brazil","Portuguese","🇧🇷"),
        ("pt-PT",       "Portuguese",      "Portugal","Portuguese","🇵🇹"),
        ("ro-RO",       "Romanian",        "Romania","Română","🇷🇴"),
        ("ru-RU",       "Russian",     "Russian Federation","русский","🇷🇺"),
        ("sk-SK",       "Slovak",      "Slovakia", "Slovenčina","🇸🇰"),
        ("sv-SE",       "Swedish",     "Sweden","Svenska","🇸🇪"),
        ("th-TH",       "Thai",        "Thailand","ภาษาไทย","🇹🇭"),
        ("tr-TR",       "Turkish",     "Turkey","Türkçe","🇹🇷"),
        ("zh-CN",       "Chinese",     "China","漢語/汉语","🇨🇳"),
        ("zh-HK",       "Chinese",   "Hong Kong","漢語/汉语","🇭🇰"),
        ("zh-TW",       "Chinese",     "Taiwan","漢語/汉语","🇹🇼")
    ]
    
}

