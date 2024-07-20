//
//  ContentView.swift
//  calculator
//
//  Created by TumbaDev on 17.07.24.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var model = StateHandler()
    
    private let buttons: [[ButtonType]] = [
        [.control(.clear), .control(.negate), .control(.percent), .operation(.div)],
        [.digit(7), .digit(8), .digit(9), .operation(.mul)],
        [.digit(4), .digit(5), .digit(6), .operation(.sub)],
        [.digit(1), .digit(2), .digit(3), .operation(.add)],
        [.digit(0), .control(.decimal), .operation(.equal)]
    ]
    
    private var buttonSize: Double {
        (UIScreen.main.bounds.width - 5 * padding) / 4.0
    }
    
    private var padding: Double {
        8
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(model.display)
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .padding(.trailing)
                    .padding(.bottom)
            }
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button {
                            model.Handle(button: button)
                        } label: {
                            Text(button.title)
                                .font(.system(size: 44))
                                .frame(width: buttonSize, height: buttonSize)
                                .frame(maxWidth: button.isWide ? .infinity : buttonSize, alignment: .leading)
                        }
                        .background(button.color)
                        .foregroundColor(button.textColor)
                        .clipShape(Capsule())
                    }
                }
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(.black)
    }
}

#Preview {
    ContentView()
}
