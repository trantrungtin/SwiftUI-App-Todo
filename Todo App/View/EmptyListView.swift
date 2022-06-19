//
//  EmptyListView.swift
//  Todo App
//
//  Created by Tin Tran on 19/06/2022.
//

import SwiftUI

struct EmptyListView: View {
    // MARK: - PROPERTY
    @State private var isAnimated: Bool = false
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData

    
    let images: [String] = [
        "illustration-no1",
        "illustration-no2",
        "illustration-no3"
    ]
    
    let tips: [String] = [
        "Use your time wisely.",
        "Slow and steady wins the race.",
        "Keep it short and sweet.",
        "Put hard tasks first.",
        "Reward yourself after work.",
        "Collect tasks ahead of time.",
        "Each night schedule for tomorrow."
    ]
    
    private var themeColor : Color {
        themes[theme.themeSetttings].themeColor
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image(images.randomElement() ?? images[0])
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                    .foregroundColor(themeColor)
                
                Text(tips.randomElement() ?? tips[0])
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(themeColor)
            }
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .onAppear {
                withAnimation(.easeOut(duration: 1.5)) {
                    self.isAnimated.toggle()
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(colorBase)
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - PREVIEW
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyListView()
            
            EmptyListView()
                .environment(\.colorScheme, .dark)
        }
    }
}
