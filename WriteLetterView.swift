//
//  WriteLetterView.swift
//  arabicLigatureWriting
//
//  Created by Mukhammad Miftakhul As'Adi on 19/04/23.
//

import SwiftUI

struct WriteLetterView: View {
    
    //decalare the width and height of the screen
    @State var screenWidth : CGFloat = UIScreen.main.bounds.width
    @State var screenHeight : CGFloat = UIScreen.main.bounds.height
    
    //declare color and thickness of pen to write in canvas
    @State var selectedColor : String = "colorRedPen"
    @State var thickness : Double = 4.0
    
    //declare slider for customizeable thickness of the pen
    @State var sliderHeight : CGFloat = 0
    @State var lastDragValue : CGFloat = 0
    
    //declare line to see the user input when draw
    @State var currentLine = Line()
    @State var lines : [Line] = []
    
    //get a selected letter that user choose
    @Binding var selectedLetters: [String]
    @Binding var selectedLettersSentence: String
    
    //get a guide of the ligature arabic
    @State var isHelp = false
    
    //get line as the initial value
    struct Line {
        var points = [CGPoint]()
        var color : Color = .white
        var lineWidth : Double = 4.0
    }
    
    var body: some View {
        NavigationStack{
            VStack (spacing: screenWidth * 0.025) {
                HStack (spacing: screenWidth * 0.025) {
                    //toggle help button of arabic ligature illustration
                    Button {
                        isHelp.toggle()
                    } label: {
                        Text("Help")
                            .font(.system(size: screenWidth * 0.03))
                            .fontWeight(.semibold)
                            .frame(width: screenWidth * 0.11145,height: screenWidth * 0.075)
                        
                            .background(LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing)
                                .cornerRadius(50)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 50, style: .continuous)
                                    .strokeBorder(Color.white, lineWidth: 8)
                            )
                    }
                    
                    //show each selected letter
                    ForEach(selectedLetters.reversed(), id: \.self) { item in
                        Text(item)
                            .font(.system(size: screenWidth * 0.04))
                            .fontWeight(.semibold)
                            .frame(width: screenWidth * 0.075,height: screenWidth * 0.075)
                        
                            .background(LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing)
                                .cornerRadius(20)
                            )
                    }
                }
                .frame(width: screenWidth * 0.7)
                
                HStack(spacing: screenWidth * 0.025){
                    //define color picker for drawing pen
                    ColorPickerView(selectedColor: $selectedColor)
                        .onChange(of: selectedColor) { newColor in
                            currentLine.color = Color("\(newColor)")
                        }
                    
                    //define canvas to draw
                    ZStack {
                        Canvas { context, size in
                            for line in lines {
                                var path = Path()
                                path.addLines(line.points)
                                context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                            }
                        }
                        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({ value in
                                let newPoint = value.location
                                currentLine.points.append(newPoint)
                                currentLine.lineWidth = thickness
                                currentLine.color = Color(selectedColor)
                                self.lines.append(currentLine)
                            })
                                .onEnded({ value in
                                    self.currentLine = Line(points: [], color : Color(selectedColor), lineWidth: thickness)
                                })
                        )
                        
                        .frame(width: screenWidth * 0.7, height: screenHeight * 0.6 )
                        .background(Color(.white))
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50, style: .continuous)
                                .strokeBorder(Color("colorTertiary"), lineWidth: 8)
                        )
                        Text(selectedLettersSentence)
                            .font(.system(size: screenWidth * 0.07))
                            .fontWeight(.light)
                            .frame(width: screenWidth * 0.7, height: screenHeight * 0.15 )
                            .offset(x: 0, y: screenHeight * -0.22)
                            .opacity(isHelp ? 0.6 : 0)
                    }
                    
                    //define thickness for drawing pen
                    VStack (spacing: screenWidth * 0.025) {
                        ZStack(alignment: .bottom) {
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                                     startPoint: .topLeading,
                                                     endPoint: .bottomTrailing))
                                .opacity(0.3)
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                                     startPoint: .topLeading,
                                                     endPoint: .bottomTrailing))
                                .opacity(1)
                                .frame(height: sliderHeight)
                            Image(systemName: "pencil.tip")
                                .font(.system(size: screenWidth * 0.05))
                                .foregroundColor(Color("colorBlack"))
                                .frame(width: screenWidth * 0.1, height: screenHeight * 0.3)
                        }
                        .frame(width: screenWidth * 0.08, height: screenHeight * 0.3)
                        
                        .cornerRadius(screenWidth)
                        .overlay(
                            RoundedRectangle(cornerRadius: screenWidth, style: .continuous)
                                .strokeBorder(Color.white, lineWidth: 8)
                        )
                        .gesture(DragGesture(minimumDistance:0 ).onChanged({ value in
                            //get drag value
                            let translation = value.translation
                            sliderHeight = -translation.height + lastDragValue
                            
                            //limit drag value to its height
                            sliderHeight = sliderHeight > screenHeight  * 0.3 ? screenHeight  * 0.3 : sliderHeight
                            sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                            
                            //manipulate slider height to a stroke thickness
                            thickness = sliderHeight
                            if thickness >= 1 {
                                thickness = sliderHeight / 307.2 * 30
                            }
                            else {
                                thickness = 1
                            }
                            print (thickness)
                        }).onEnded({ (value) in
                            
                            //storing last drag value
                            lastDragValue = sliderHeight
                            
                            //limit drag value to its height
                            sliderHeight = sliderHeight > screenHeight  * 0.3 ? screenHeight  * 0.3 : sliderHeight
                            sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                            
                            //manipulate slider height to a stroke thickness
                            thickness = sliderHeight
                            if thickness >= 1 {
                                thickness = sliderHeight / 307.2 * 30
                            }
                            else {
                                thickness = 1
                            }
                            print (thickness)
                        }))
                        
                        //define button to get the blank canvas
                        Button {
                            self.lines = []
                        } label: {
                            Image(systemName: "eraser.fill")
                                .font(.system(size: screenWidth * 0.04))
                                .foregroundColor(Color("colorBlack"))
                        }
                        .frame(width: screenWidth * 0.08, height: screenHeight * 0.175)
                        .background(LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing)
                        )
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: screenWidth, style: .continuous)
                                .strokeBorder(Color.white, lineWidth: 8)
                        )
                    }
                }
                
                //bring user to the first appview
                NavigationLink(destination: AppView().navigationBarBackButtonHidden(false))  {
                    Text("Finish Writing")
                        .font(.system(size: screenWidth * 0.03))
                        .fontWeight(.regular)
                        .frame(width: screenWidth * 0.3, height: screenHeight * 0.09)
                        .background(LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing)
                            .cornerRadius(screenWidth))
                }
            }
            .frame(width: screenWidth, height: screenHeight)
            .background(Color("colorBg"))
            .foregroundColor(Color("colorBlack"))
        }
    }
}

struct WriteLetterView_Previews: PreviewProvider {
    static var previews: some View {
        //call the binding data from selectedview
        WriteLetterView(selectedLetters: .constant([""]), selectedLettersSentence: .constant(""))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
