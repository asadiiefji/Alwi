//
//  SelectLetterView.swift
//  arabicLigatureWriting
//
//  Created by Mukhammad Miftakhul As'Adi on 19/04/23.
//

import SwiftUI

struct SelectLetterView: View {
    
    //decalare the width and height of the screen
    @State var screenWidth : CGFloat = UIScreen.main.bounds.width
    @State var screenHeight : CGFloat = UIScreen.main.bounds.height
    
    //declare to get a selected letter that user choose
    @State var selectedLetters: [String] = []
    @State var selectedLettersSentence: String = ""
    
    var body: some View {
        HStack {
            NavigationStack {
                
                //Show the selected letter that is combined if the user selects more than one data
                Text(selectedLettersSentence)
                    .font(.system(size: screenWidth * 0.07))
                    .fontWeight(.light)
                    .frame(width: screenWidth * 0.5, height: screenHeight * 0.15 )
                    .background(Color("colorPrimary"))
                    .cornerRadius(30)
                    .onAppear {
                        updateSelectedLettersSentence()
                    }
                
                //Show the Hijaiyah letters
                VStack {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: screenWidth * 0.10))]) {
                        ForEach(hijaiyahLetters, id: \.self) { letter in
                            Button(action: {
                                toggleSelection(letter)
                                
                            }) {
                                Text(letter)
                                    .font(.system(size: screenWidth * 0.04))
                                    .fontWeight(.semibold)
                                    .frame(width: screenWidth * 0.075,height: screenWidth * 0.075)
                                
                                    .background(LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                                               startPoint: .topLeading,
                                                               endPoint: .bottomTrailing)
                                        .cornerRadius(20)
                                    )
                                    .foregroundColor(selectedLetters.contains(letter) ? .red : .primary)
                            }
                            .padding(21)
                        }
                    }
                }
                
                //navigate to write view and pass the selected letter in sentence and each letter separately
                NavigationLink(destination: WriteLetterView(selectedLetters: $selectedLetters, selectedLettersSentence: $selectedLettersSentence).navigationBarBackButtonHidden(false))  {
                    Text("Finish Selection")
                        .font(.system(size: screenWidth * 0.03))
                        .fontWeight(.regular)
                        .foregroundColor(Color("colorBlack"))
                        .frame(width: screenWidth * 0.3, height: screenHeight * 0.09)
                        .background(LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing)
                            .cornerRadius(screenWidth))
                }
            }.frame(width: screenWidth * 0.9, alignment: .center)
        }
    }
    
    //function to select and unselect the letter, also call the update sentence
    private func toggleSelection(_ letter: String) {
        if let index = selectedLetters.firstIndex(of: letter) {
            selectedLetters.remove(at: index)
        } else {
            selectedLetters.append(letter)
        }
        updateSelectedLettersSentence()
    }
    
    //function to update selected sentence
    private func updateSelectedLettersSentence() {
        selectedLettersSentence = selectedLetters.joined(separator: "")
    }
}

struct SelectLetterView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLetterView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
