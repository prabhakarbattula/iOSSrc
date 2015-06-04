*** Settings ***
Library           AppiumLibrary

*** Variables ***
${REMOTE_URL}     http://localhost:4723/wd/hub # URL to appium server
${PLATFORM_NAME}    iOS
#${PLATFORM_VERSION}    8.2
${DEVICE_NAME}    Mrudul's iPhone
# Appium uses the *.app directory that is created by the ios build to provision the emulator.
${APP_LOCATION}		${CURDIR}/../../build/Release-iphoneos/UICatalog.app


 
*** Keywords ***
Open App
   Open Application    http://localhost:4723/wd/hub		platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    app=${APP_LOCATION}

Close All Apps
   Close All Applications



*** Test Cases ***

I Open Application
	Open App

I Check Element
	Page Should Contain Element		name=UICatalog		class=UIAButton

I Check Text
	Page Should Contain Text	text=Explore UIKit controls as you navigate UICatalog. For more information on how UICatalog is structured, consult the ReadMe.	

I Press Back
	Click Element		name=UICatalog

I Scroll
	Scroll		name=Steppers		name=Buttons

I Put Application to Background
	Background App

I Close App
	Close Application

I Close All Applications
	Close All Apps