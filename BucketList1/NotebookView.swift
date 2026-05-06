//
//  NotebookView.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/27/26.
//

import SwiftUI

struct NotebookView: View {
    @EnvironmentObject var imageCollection:images
    var body: some View {
        NavigationStack {
            ZStack {
                
                Image("cover")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 350, height: 300)
                    
                    Spacer().frame(height: 250)
                    
                    NavigationLink{
                        InterestPageView()
                    } label: {
                        Text(" Get Started               ")
                    }.buttonStyle(.borderedProminent)
                        .buttonStyle(.borderedProminent)
                        .tint(.redd)
                    
                }
            }
        }
    }
}

#Preview {
    NotebookView()
}
