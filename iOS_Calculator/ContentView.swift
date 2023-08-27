//
//  ContentView.swift
//  iOS_Calculator
//
//  Created by Salva Moreno on 5/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(viewModel.textFieldValue)
                            .foregroundColor(.white)
                            .font(.system(size: viewModel.textFieldValue.count > 8 ? 50 : viewModel.textFieldValue.count > 5 ? 70 : 100, weight: .regular))
                            .frame(height: 100)
                            .padding(.trailing, 20)
                    }
                    .padding(.bottom, 20)
                    VerticalButtonStack(viewModel: viewModel, data: Matrix.firstSectionData, columns: Matrix.firstSectionGrid(proxy.size.width * 0.25), width: proxy.size.width)
                    VerticalButtonStack(viewModel: viewModel, data: Matrix.secondSectionData, columns: Matrix.secondSectionGrid(proxy.size.width * 0.25), width: proxy.size.width)
                }
            }
            .background(Color.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
