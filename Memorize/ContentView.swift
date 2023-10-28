//
//  ContentView.swift
//  Memorize
//
//  Created by Duy Nguyen on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    
    let theme: [[String]]
    let halloween: Array<String> =
        ["💀","👻","🎃","👿","👻","💀","👻","🎃","👿","👻","👹","👹","👺","👺","😨","😨"]
    let winter: Array<String> = ["🥶","❄️","☃️","🧣","🏂","🎿","🥌","⛸️","🥶","❄️","☃️","🧣","🏂","🎿","🥌","⛸️"]
    let spring: Array<String> = ["🌹","🌸","🌺","🌷","🌼","🍃","♨️","🧹","🌹","🌸","🌺","🌷","🌼","🍃","♨️","🧹"]
    let themename = ["halloween", "winter", "spring"]
    let symbols = ["questionmark.folder.ar","cloud","leaf"]
    @State var cardCount = 4
    @State var selectedtheme = "halloween"
    init(){
       
        theme = [halloween,winter,spring]
    }
  
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle).foregroundColor(.black)
            cards
            Spacer()
            //cardCountAdjusters
            themebuttons
            }
        .padding()
    }
    
    var themebuttons: some View{
        HStack{
            themeSelection
        }
    }
    
    var themeSelection : some View{
        ForEach(0..<themename.count,id:\.self){index in
            Button(action: {selectedtheme = themename[index]}, label: {
                VStack{
                    HStack{
                        Spacer()
                        Image(systemName: symbols[index]).font(.largeTitle)
                        Spacer()
                    }
                    Text(themename[index])
                }
            })
        }
    }
    

    var cards: some View{
        var themeindex: Int = 0
        if selectedtheme == "halloween"{
            themeindex = 0
        }else if selectedtheme == "winter"{
            themeindex = 1
        }else{
            themeindex = 2
        }
        return LazyVGrid(columns: [GridItem(.adaptive(minimum:100))]){ //telling it the minimum width for the grid item
            let shuffletheme = theme[themeindex].shuffled()
        
            ForEach(0..<shuffletheme.count, id: \.self){ index in
                Cardview(content:shuffletheme[index])
                    .aspectRatio(3/2 , contentMode: .fit)
                // change card size to 2:3
            }.foregroundColor(.red)
        }
        
    }
}
    


#Preview {
    ContentView()
}



struct Cardview: View{
    let content: String
    @State var isFaceUp = false
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 3 )
                Text(content).font(.largeTitle)
                
            }
            .opacity(isFaceUp ? 1 : 0 )

            base.fill().opacity(isFaceUp ? 0 : 1) //change the opacity if faceup is true or false
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}


/*
 func cardCountAdjuster(by offset:Int , symbol : String)-> some View{
 Button(action:{
 cardCount += offset
 },label :{Image(systemName: symbol)})
 .disabled(cardCount + offset < 1 || cardCount + offset > halloween.count) //this disables the button when the condition is satisfied.
 }
 */

/*var cardRemover : some View{
 return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
 }
 
 var cardAdder : some View{
 return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
 
 }*/

/*struct Themeselection: View{
    let themeselected: String
    var body:some View{
        ZStack{
            let base1 = RoundedRectangle(cornerRadius: 12)
            base1.fill(.white)
            base1.strokeBorder(lineWidth: 3 )
            Text(themeselected)
            
        }
    }
}*/
