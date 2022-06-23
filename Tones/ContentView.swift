//
//  ContentView.swift
//  Tones
//
//  Created by Jamie White on 17/06/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var note = Note.C
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color(note.letter)
                .ignoresSafeArea()
            VStack {
                Spacer()
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
                Spacer()
            }
        }
        .onReceive(timer) { _ in
            var newNote = note
            while newNote == note {
                newNote = Note.allCases.randomElement()!
            }
            self.note = newNote
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
