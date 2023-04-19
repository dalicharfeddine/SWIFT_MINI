//
//  CarView.swift
//  CarLovers
//
//  Created by DaliCharf on 23/3/2023.
//

import SwiftUI

struct Card: View {
    let car: carResponse
    
    @State private var translation: CGSize = .zero
    @State private var onLike: Bool = false
    @State private var onDislike: Bool = false
    
    var body: some View {
        ZStack {
            CarView(imageURL: car.image)
                .cornerRadius(20)
            
            VStack {
                Spacer()
                
                .padding(20)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height * 0.7)
        .offset(translation)
        .rotationEffect(.degrees(Double(translation.width / 10)))
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.translation = value.translation
                }
                .onEnded { value in
                    if abs(self.translation.width) > 100 {
                        if self.translation.width > 0 {
                            self.onLike = true
                        } else {
                            self.onDislike = true
                        }
                    } else {
                        self.translation = .zero
                    }
                }
        )
        .animation(.spring())
    }
}



struct CarView: View {
    let imageURL: String
    @State private var image: UIImage? = nil

    var body: some View {
        Image(uiImage: image ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height * 0.7)
            .cornerRadius(20)
            .padding(20)
            .onAppear {
                if let url = URL(string: imageURL) {
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async {
                            self.image = UIImage(data: data)
                        }
                    }.resume()
                }
            }
    }
}

    
   

struct CardStackView: View {
    @StateObject private var viewModel = cardStackviewmodel()
    @State private var offset = CGSize.zero
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(viewModel.cars.indices.reversed(), id: \.self) { index in
                    let car = viewModel.cars[index]
                    Card(car: car)
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
                                withAnimation(.spring()){ if abs(offset.width) > 100 {
                                    if offset.width > 0 {
                                        like()
                                    } else {
                                        dislike()
                                    }
                                    currentIndex += 1
                                } else {

                                    offset = .zero
                                }
                                    print(offset)
                                }})
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            
            .padding(.bottom, 30)
        }
        .onAppear {
            viewModel.getCars()
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
        if abs(offset.width) > 100 {
            // Supprimer l'élément liké de la liste
            viewModel.cars.remove(at: currentIndex)
            
            if currentIndex != 0 {
                currentIndex -= 1
            }
            
            // Ajouter ici la logique pour ajouter un like
            print("Liked car: \(viewModel.cars[currentIndex].model)")
        }
    }

    func dislike() {
        if abs(offset.width) > 100 {
            // Supprimer l'élément disliké de la liste
            viewModel.cars.remove(at: currentIndex)
            
            if currentIndex != 0 {
                currentIndex -= 1
            }
            
            // Ajouter ici la logique pour ajouter un dislike
            print("Disliked car: \(viewModel.cars[currentIndex].model)")
        }
    }





}
struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
