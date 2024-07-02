//
//  Moonshot.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/2.
//

import SwiftUI

struct Moonshot: View {
    @State var isList = false
    let astronauts : [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
        
    ]

    
    
    var body: some View {
        NavigationStack {


                Group {
                    if isList {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                myContent(m:self)
                            }
                        }
                        .padding([.horizontal, .bottom])
                    } else {
                        List {
                            myContent(m : self)
                        }
                    }
                }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Add Expense", systemImage: "list.bullet") {
                    isList.toggle()
                }
            }


        }

    }
    
    struct myContent: View {
        var  m : Moonshot
        var body: some View {
 
            ForEach(m.missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: m.astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))

                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
        
    }
}

#Preview {
    Moonshot()
}
