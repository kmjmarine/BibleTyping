//
//  Speaker.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/09/16.
//

import AVFoundation

final class TTSManager: NSObject {
    //Type Property
    static let shared = TTSManager()
    
    let synthesizer = AVSpeechSynthesizer()
    
    override init() {
        super.init()
    }
    
    internal func play(_ string: String, _ languageCode: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: languageCode)
        utterance.rate = 0.4
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .duckOthers)
    }
    
    internal func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}


