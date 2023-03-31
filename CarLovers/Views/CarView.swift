//
//  CarView.swift
//  CarLovers
//
//  Created by DaliCharf on 23/3/2023.
//

import SwiftUI

struct Card: View {
    let imageName: String
    
    var body: some View {
        CarView(imageName: imageName)
    }
}

struct CarView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height * 0.7)
            .cornerRadius(20)
            .padding(20)
    }
}

struct CardStackView: View {
    @State private var cards = ["bmw", "welcome1", "welcome2", "card4", "card5", "card6", "card7", "card8", "card9", "card10"]
    @State private var offset = CGSize.zero
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(cards.indices.reversed(), id: \.self) { index in
                    Card(imageName: cards[index])
                        .offset(y: CGFloat(index - currentIndex) * 15)
                        .offset(x: offset.width, y: offset.height)
                        .scaleEffect(getScale(index: index))
                        .rotationEffect(Angle(degrees: getRotation(index: index)))
                        .animation(.spring())
                        .gesture(DragGesture()
                            .onChanged { value in
                                offset = value.translation
                            }
                            .onEnded { value in
                                withAnimation(.spring()) {
                                    if abs(offset.width) > 100 {
                                        if offset.width > 0 {
                                            like()
                                        } else {
                                            dislike()
                                        }
                                    }
                                    offset = .zero
                                }
                            })
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    dislike()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                })
                .disabled(currentIndex == 0)
                
                Button(action: {
                    like()
                }, label: {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.green)
                })
                .disabled(currentIndex == cards.count - 1)
            }
            .padding(.bottom, 30)
        }
    }
    
    func getScale(index: Int) -> CGFloat {
        let diff = CGFloat(index - currentIndex)
        if diff == 0 {
            return 1.0
        } else if diff == 1 || diff == -1 {
            return 0.95
        } else {
            return 0.9
        }
    }
    
    func getRotation(index: Int) -> Double {
        let diff = Double(index - currentIndex)
        return diff * 5.0
    }
    
    func like() {
        cards.remove(at: currentIndex)
        if currentIndex != 0 {
            currentIndex -= 1
        }
    }
    
    func dislike() {
        cards.remove(at: currentIndex)
        if currentIndex != 0 {
            currentIndex -= 1
        }
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
