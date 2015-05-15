*** Settings ***

Library                 IOSLibrary


*** Keywords ***
// Suite Setup             Setup Simulator
// Suite Teardown          Stop Simulator


Setup Simulator
//    Set Device   iPhone (Retina) 
//Set Device URL      http://localhost:37265
//    Set Simulator    /Applications/Xcode.app/Contents/Applications/iPhone Simulator.app/Contents/MacOS/iPhone Simulator
    Start Simulator     RecipeBookSimpl.app   sdk=8.2
    Wait Until Keyword Succeeds
    ...   1min
    ...   5sec
    ...   Is device available

// I can search for buttons
//    Query  "button"

// I can touch buttons
//   touch   button
//I can toggle switch
  //  touch   tabBarButton index:0
   // Toggle switch
//I can pinch
  //  touch   tabBarButton index:1
   // pinch   out
   // pinch   in  view:'MKMapView'

//I can swipe
//    Set device orientation to   down
//    swipe   right
//    swipe   left

//I can check content
//    touch   tabBarButton index:0
//    Screen should contain   Name

//I can enter text
//    Set text    Spam   query=textField
//    Screen should contain text  Spam
//I can handle webviews
//    touch   tabBarButton index:3
//    Webview should not be empty
//    Wait Until Keyword Succeeds   10sec   2sec
//    ...     Webview should contain  Google   index=0
// I can scroll
//    touch   tabBarButton index:2
//    scroll  up
//    scroll  down query=scrollView index:0

// Set device orientation to   right
//    Set device orientation to   up
//    rotate  right
//    Set device orientation to   down    direction=left

*** Test Cases ***


I can take a screenshot
   Capture Screenshot

I can touch position
   Touch position  x=35   y=35




I can rotate the device to
    Set device orientation to   left
   
