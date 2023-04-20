//
//  AppView.swift
//  arabicLigatureWriting
//
//  Created by Mukhammad Miftakhul As'Adi on 18/04/23.
//

import SwiftUI

struct AppView: View {
    
    @State var screenWidth : CGFloat = UIScreen.main.bounds.width
    @State var screenHeight : CGFloat = UIScreen.main.bounds.height
    
    @State private var currentIndex = 0
    
    var body: some View {
        NavigationStack {
            
            //show the stepper introduction of the appp
            HStack(spacing: screenWidth * 0.05) {
                ZStack{
                    Image("logo")
                        .resizable()
                        .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
                        .overlay(
                            RoundedRectangle(cornerRadius: screenWidth)
                                .stroke(Color("colorBg"), lineWidth: 15)
                        )
                        .offset(x: 0, y: screenWidth * -0.24)
                    
                    VStack{
                        Spacer()
                        Spacer()
                        Text ("I am Alwi")
                            .font(.system(size: screenWidth * 0.05))
                            .fontWeight(.bold)
                        Text ("Arabic Ligature Writing")
                            .font(.system(size: screenWidth * 0.03))
                            .fontWeight(.regular)
                        //set the amount of stepper data
                        HStack(spacing: 30) {
                            Text("1")
                                .font(.system(size: screenWidth * 0.03))
                                .fontWeight(.semibold)
                                .frame(width: screenWidth * 0.055,height: screenWidth * 0.055)
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("colorPrimary")))
                                .opacity(currentIndex >= 0 ? 1 : 0.4)
                            Text("2")
                                .font(.system(size: screenWidth * 0.03))
                                .fontWeight(.semibold)
                                .frame(width: screenWidth * 0.055,height: screenWidth * 0.055)
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("colorPrimary")))
                                .opacity(currentIndex >= 1 ? 1 : 0.4)
                            Text("3")
                                .font(.system(size: screenWidth * 0.03))
                                .fontWeight(.semibold)
                                .frame(width: screenWidth * 0.055,height: screenWidth * 0.055)
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("colorPrimary")))
                                .opacity(currentIndex >= 2 ? 1 : 0.4)
                            Text("4")
                                .font(.system(size: screenWidth * 0.03))
                                .fontWeight(.semibold)
                                .frame(width: screenWidth * 0.055,height: screenWidth * 0.055)
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("colorPrimary")))
                                .opacity(currentIndex >= 3 ? 1 : 0.4)
                        }
                        .frame(width: screenWidth * 0.33, height: screenHeight * 0.1)
                        .background(Color.white)
                        .foregroundColor(.white)
                        .cornerRadius(screenWidth)
                        
                        //create a button to get back and next of the stepper
                        HStack {
                            Button {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    print(currentIndex)
                                }
                            } label: {
                                Image(systemName: currentIndex == 0 ? "xmark" : "chevron.left")
                                    .font(.system(size: screenWidth * 0.04))
                                    .disabled(currentIndex == 0)
                            }
                            .frame(width: 150, height: 100)
                            .background( LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing)
                                .cornerRadius(screenWidth)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: screenWidth)
                                    .stroke(Color.white, lineWidth: 4)
                            )
                            .opacity(currentIndex == 0 ? 0.2 : 1)
                            Spacer()
                            
                            Button {
                                if currentIndex < text.count - 1 {
                                    currentIndex += 1
                                }
                                print(currentIndex)
                            } label: {
                                if currentIndex == text.count - 1{
                                    NavigationLink(destination: SelectLetterView().navigationBarBackButtonHidden(false)) {
                                        Image(systemName:"arrow.forward")
                                            .font(.system(size: screenWidth * 0.04))
                                    }
                                }
                                
                                else {
                                    Image(systemName:"chevron.right")
                                        .font(.system(size: screenWidth * 0.04))
                                        .disabled(currentIndex == text.count - 1)
                                }
                                
                                
                            }
                            .frame(width: 150, height: 100)
                            .background( LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing)
                                .cornerRadius(screenWidth)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: screenWidth)
                                    .stroke(Color.white, lineWidth: 4)
                            )
                            
                        }
                        .frame(width: screenWidth * 0.33)
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                    }
                }
                .frame(width: screenWidth * 0.4, height: screenHeight * 0.6)
                .background( LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing)
                    .cornerRadius(50)
                )
                
                //show the content each stepper
                VStack{
                    Text (title[currentIndex])
                        .font(.system(size: screenWidth * 0.18))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.trailing)
                        .frame(width: screenWidth * 0.45, height: screenWidth * 0.2)
                    Rectangle()
                        .fill(LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                             startPoint: .topLeading,
                                             endPoint: .bottomTrailing))
                        .frame(width: screenWidth * 0.45, height: screenWidth * 0.01)
                    Text (text[currentIndex])
                    
                        .font(.system(size: screenWidth * 0.025))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: screenWidth * 0.45)
            }
            .frame(width: screenWidth, height: screenHeight)
            .foregroundColor(Color("colorBlack"))
            .background(Color("colorBg"))
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

