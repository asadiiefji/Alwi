//
//  ColorPickerView.swift
//  arabicLigatureWriting
//
//  Created by Mukhammad Miftakhul As'Adi on 19/04/23.
//

import SwiftUI

struct ColorPickerView: View {
    
    @State var screenWidth : CGFloat = UIScreen.main.bounds.width
    @State var screenHeight : CGFloat = UIScreen.main.bounds.height
    @State var idColor : String = ""
    @Binding var selectedColor : String
    
    var body: some View {
        VStack(spacing: screenWidth * 0.02){
            ForEach(colorPen, id: \.self) { item in
                
                Image(systemName: selectedColor == item ? "record.circle" : "circle.fill")
                    .background(selectedColor == item ? .white : Color("colorTertiary"))
                    .foregroundColor(Color("\(item)"))
                    .font(.system(size: screenWidth * 0.05))
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = item
                    }
            }
        }
        .frame(width: screenWidth * 0.08, height: screenHeight * 0.45)
        .background(LinearGradient(colors: [Color("colorPrimary"), Color("colorTertiary"),  Color("colorSecondary")],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
        .overlay(
            RoundedRectangle(cornerRadius: screenWidth, style: .continuous)
                .strokeBorder(Color.white, lineWidth: 8)
        )
        .cornerRadius(screenWidth)
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView( selectedColor : .constant("colorRedPen"))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
