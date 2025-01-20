Setup Instructions
	1.	Clone the Repository

    git clone https://github.com/YourUsername/WeatherTracker.git
    cd WeatherTracker

	2.	Open in Xcode
	  
    • Double-click the WeatherTracker.xcodeproj (or .xcworkspace if you're using Swift Packages/CocoaPods) to open in Xcode.
	  •	Alternatively, launch Xcode and choose File → Open → select the project folder.
   
	3.	Set Up Secrets (API Key)
	  •	Create a configuration file, for example, Secrets.xcconfig, to store your private API key(s).
	  •	Select File, New, File From Template, and select "Configuration Settings File."
    •	Open the file and add the following line:
    
      WEATHER_API_KEY = <your_api_key_here>

	4.	Make sure to add Secrets.xcconfig as the build configuration for Debug/Release in Project Settings → Info (or Build Settings).
 
	5.	Add it to .gitignore so it doesn't leak to your remote repository.

	6.	Compile & Run
	  •	In Xcode, select your app target from the scheme menu (e.g., "WeatherTracker"), then press Run (⌘ + R).
	  •	To run on an actual device, ensure you have a valid developer profile or an Apple Developer account.
	  •	For simulators, select a simulator (e.g., "iPhone 14 Pro") in the scheme menu.

	7.	Troubleshooting
	  •	If you get Build Errors about missing keys, confirm that you set up Secrets.xcconfig correctly and that your .xcconfig keys match the placeholders in Info.plist.
	  •	Ensure your API key is valid.
