//
//  ContentView.swift
//  Tones
//
//  Created by Jamie White on 17/06/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    static let practiceSeconds = 5 * 60
    
    @Environment(\.scenePhase) var scenePhase
    
    @State var note = Note.C
    @State var secondsRemaining = practiceSeconds
    @State var isActive = true
    @State var isTiming = false
    
    let seconds = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let notes = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color(note.letter)
                .ignoresSafeArea()
                .zIndex(0)
            VStack {
                if isTiming {
                    Text(timerText())
                        .foregroundColor(.white)
                        .padding()
                }
                Spacer()
                if isTiming {
                    Button("Stop") { reset() }
                        .buttonStyle(.bordered)
                        .foregroundColor(.white)
                } else {
                    Button("Practise for 5 Minutes") {
                        isTiming = true
                    }
                        .buttonStyle(.bordered)
                        .foregroundColor(.white)
                }

            }
            .padding()
            VStack {
                Text(note.letter)
                    .font(.system(size: 100, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .drawingGroup()
                Spacer()
                    .frame(height: 100)
                Text(note.solfege)
                    .font(.system(size: 100, design: .serif))
                    .italic()
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .drawingGroup()
            }
            .id("note-\(note.letter)")
            .zIndex(1)
            .transition(.opacity.combined(with: .slide))
                        
        }
        .onReceive(seconds) { _ in
            if !isActive {
                return
            }
            if !isTiming {
                return
            }
            
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            } else {
                reset()
            }
        }
        .onReceive(notes) { _ in
            if !isActive {
                return
            }
            if !isTiming {
                return
            }

            chooseNewNote()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                isActive = true
            } else {
                isActive = false
            }
        }
    }
    
    func chooseNewNote() {
        var newNote = note
        while newNote == note {
            newNote = Note.allCases.randomElement()!
        }
        withAnimation {
            self.note = newNote
        }
    }
    
    func timerText() -> String {
        let minutes = String(secondsRemaining / 60)
        var seconds = String(secondsRemaining % 60)
        
        if seconds.count < 2 {
            seconds = "0\(seconds)"
        }
        
        return "\(minutes):\(seconds)"
    }
    
    func reset() {
        isTiming = false
        secondsRemaining = ContentView.practiceSeconds
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
