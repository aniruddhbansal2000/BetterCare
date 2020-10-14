//
//  ContentView.swift
//  TOC
//
//  Created by Aviral Yadav on 13/10/20.
//

import SwiftUI

struct ContentView: View {
    @State private var showSecondVC=false
    @State private var age = 40
    @State private var selectedGenderIndex: Int = 0
    private var genderOptions = ["🙍‍♂️ Male", "🙍‍♀️ Female"]
    @State private var weight = 70
    @State private var height = 170
    @State private var ap_hi=120
    @State private var ap_lo=80
    @State private var cho=0
    @State private var glu=0
    @State private var smoke=0
    @State private var alc=0
    @State private var phy=0
    @State private var selectedchoIndex: Int = 0
    @State private var selectedgluIndex: Int = 0
    @State private var selectedsmoIndex: Int = 0
    @State private var selectedalcIndex: Int = 0
    @State private var selectedphyIndex: Int = 0
    @State private var alertTitle=""
    @State private var alertMessage=""
    @State private var showingAlert=false
    private var choOptions = ["Normal","Above Normal", "Well Above Normal"]
    private var smokeOptions = ["YES","NO"]
    
    var body: some View {
        NavigationView{
            ZStack(){
                LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                ZStack(){
                    VStack(){
                        Form{
                            Group{
                                Picker("Gender", selection: $selectedGenderIndex) {
                                    ForEach(0..<genderOptions.count) {
                                        Text("\(genderOptions[$0])")
                                    }
                                }
                                Picker("Age", selection: $age) {
                                    ForEach(10...80, id:\.self) {
                                        Text("\($0)")
                                    }
                                }
                                Picker("Height(cms)", selection: $height) {
                                    ForEach(150...200, id:\.self) {
                                        Text("\($0)")
                                    }
                                }
                                Picker("Weight(kgs)", selection: $weight) {
                                    ForEach(70...200, id:\.self) {
                                        Text("\($0)")
                                    }
                                }
                            }
                            Group{
                                Picker("Systolic blood pressure", selection: $ap_hi) {
                                    ForEach(110...160, id:\.self) {
                                        Text("\($0)")
                                    }
                                }
                                Picker("Diastolic blood pressure", selection: $ap_lo) {
                                    ForEach(60...100, id:\.self) {
                                        Text("\($0)")
                                    }
                                }
                                Picker("Cholestrol", selection: $selectedchoIndex) {
                                    ForEach(0..<choOptions.count) {
                                        Text("\(choOptions[$0])")
                                    }
                                }
                                Picker("Glucose", selection: $selectedgluIndex) {
                                    ForEach(0..<choOptions.count) {
                                        Text("\(choOptions[$0])")
                                    }
                                }
                            }
                            Group{
                                Picker("Smoking", selection: $selectedsmoIndex) {
                                    ForEach(0..<smokeOptions.count) {
                                        Text("\(smokeOptions[$0])")
                                    }
                                }
                                Picker("Alcohol", selection: $selectedalcIndex) {
                                    ForEach(0..<smokeOptions.count) {
                                        Text("\(smokeOptions[$0])")
                                    }
                                }
                                Picker("Physical Activity", selection: $selectedphyIndex) {
                                    ForEach(0..<smokeOptions.count) {
                                        Text("\(smokeOptions[$0])")
                                    }
                                }
                            }
    
                        }
                        Button(action:CalculateDisease)
                        {
                            
                                    Text("DETECT")
//                                        .sheet(isPresented:$showSecondVC){
//                                            SecondView()
//                                        }
                        }.alert(isPresented: $showingAlert){
                            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                                .frame(width: 210, height: 30, alignment: .center)
                                .foregroundColor(.yellow)
                                .padding(.all)
                                .background(Color.black)
                                .cornerRadius(16)
    
                    }
                }
                    .navigationBarTitle("BetterCare")
            }
        }
    }
    
    func CalculateDisease(){
        let model = HeartCalculator()
        do{
            let prediction=try model.prediction(age: Double(age), gender: Double(selectedGenderIndex), height: Double(height), weight: Double(weight), ap_hi: Double(ap_hi), ap_lo: Double(ap_lo), cholesterol: Double(selectedchoIndex), gluc: Double(selectedgluIndex), smoke: Double(selectedsmoIndex), alco: Double(selectedalcIndex), active: Double(selectedphyIndex))
            
            let finalanswer=prediction.cardio
            
            if(finalanswer==0){
                alertMessage="NO DISEASE DETECTED"
            }
            else{
                alertMessage="CARDIOVASCULAR DISEASE DETECTED"
            }
            
            alertTitle="REPORT"
            
            
        }catch{
            alertTitle="Error"
            alertMessage="There was a problem calculating your metrics"
        }
        showingAlert=true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
