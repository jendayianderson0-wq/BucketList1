//
//  ContentView.swift
//  BucketList
//
//  Created by Charlotte Robinson on 4/6/26.
//
// can we add this?

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            ZStack {
             
                Image("Cover")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    ZStack{
                        Image("Logo")
                            .resizable()
                            .frame(width: 350, height: 300)
                    }
                    NavigationLink{
                        HomeroomView()
                    } label: {
                        Text("Get Started")
                    }.buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
