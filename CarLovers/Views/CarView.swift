//
//  CarView.swift
//  CarLovers
//
//  Created by DaliCharf on 23/3/2023.
//

import SwiftUI

struct Card: View {
    let car: carResponse
    
    @State  var translation: CGSize = .zero
    @State  var onLike: Bool = false
    @State  var onDislike: Bool = false
    @ObservedObject  var viewModel : cardStackviewmodel

    var body: some View {
        ZStack() {
            CarView(imageURL: car.image)
                .scaledToFit()
                .cornerRadius(20)
                .padding(.horizontal, 16)
            VStack{
                Spacer()
                HStack{
                    VStack(alignment: .leading) {
                        Text(car.marque)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .multilineTextAlignment(.leading)
                        
                            .cornerRadius(20)
                        
                        Text(car.model)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .multilineTextAlignment(.leading)
                        
                            .cornerRadius(20)
                        
                        Text(car.description)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .cornerRadius(20)
                    }
                    Spacer()
                }
                
            }.padding(70)
        
            HStack {
                Spacer()
                
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.red)
                    .padding(.trailing, 80)
                    .opacity(Double(translation.width / -200))
                    .animation(.spring())
                    .onTapGesture {
                        self.onDislike = true
                    }
                
                Image(systemName: "heart.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                    .padding(.leading, 80)
                    .opacity(Double(translation.width / 200))
                    .animation(.spring())
                    .onTapGesture {
                        self.onLike = true
                    }
                
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height * 0.7)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 16)
        .offset(translation)
        .rotationEffect(.degrees(Double(translation.width / 100)))
        .scaleEffect(onLike || onDislike ? 0.9 : 1.0)
        .opacity(onLike || onDislike ? 0.0 : 5)
        .gesture(
            DragGesture()
                .onChanged { value in
                    let newTranslation = CGSize(width: value.translation.width - self.translation.width, height: value.translation.height - self.translation.height)
                    self.translation = newTranslation
                }
                .onEnded { value in
                    if abs(self.translation.width) > 100 {
                        if self.translation.width > 0 {
                            self.onLike = true

                            viewModel.getContact(for: car.user)
                            
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
    @StateObject  var viewModel = cardStackviewmodel()
    @State private var offset = CGSize.zero
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            ZStack {
                
                ForEach(viewModel.cars.indices, id: \.self) {
                    index in
                    
                    let car = viewModel.cars[index]
                    Card(car: car, viewModel:viewModel)
                        .offset(y: CGFloat(index - currentIndex) * 15)
                        .offset(x: offset.width, y: offset.height)
                        .scaleEffect(getScale(index: index))
                        .rotationEffect(Angle(degrees: getRotation(index: index)))
                        .animation(.spring())
                    
                    
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            HStack(spacing: 30) {
                Button(action: {
                    dislike()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    like()
                }) {
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                }
            }
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
        viewModel.cars.remove(at:currentIndex)

        
        
            if let firstCar = viewModel.cars.first {
                viewModel.getContact(for: firstCar.user)
            } else {
                print("Error: No cars found")
            }
        

    }
    
    func dislike() {
        print("Disliked car: \(viewModel.cars[currentIndex].model)")
        viewModel.cars.remove(at:currentIndex)
       
        print(currentIndex)

    }
}


struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
