//
//  proj9ch4moonshot.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/3.
//

import SwiftUI

struct proj9ch4moonshot: View {
    //TODO need to add path for MissionView and AsronautView
    
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

                        List {
                            myContent(m : self)
                        }
//                        List(0..<3) { i in
//                            NavigationLink("Tap Me\(i)") {
//                                DetailView22(number: i)
//                            }
//                        }
                        
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                myContent(m:self)
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom])
                    .navigationDestination(for: Mission.self) { selection in
//                        MissionView(mission: selection, astronauts: astronauts)
                        Image(selection.image)
                    }

            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("UseListVIew", systemImage: "list.bullet") {
                    isList.toggle()
                }
            }


        }

    }
    

    
    struct myContent: View {
        var  m : proj9ch4moonshot
        var body: some View {
 
            ForEach(m.missions) { mission in
                NavigationLink(value: mission)
                    {
////                        MissionView(mission: mission, astronauts: m.astronauts)
//                    } label: {
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
    proj9ch4moonshot()
}
