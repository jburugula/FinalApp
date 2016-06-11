# FinalApp

Carnatic Music Learning App 
Description 
This app facilitates its users to watch and learn traditional form of South Indian Classical music playing. Famous artists who have mastered this tradition and who are practicing musicians share high quality videos and lectures. This enables aspirants of all levels who live across the globe to get access to the content created by these artists. This can augment and also set standards for the learners who do not have access to teachers of this calibre. 
It is a subscription based service, upon subscribing to the different levels of services users can watch and learn from these videos and at their own pace. In future app facilitates a 1:­1 dialog with the teachers. 

Intended User 
This is for all Carnatic music learners across globe, who don’t have access to top quality artists. Just by subscribing to the service users can learn this great art form at their own pace. This requires internet connection with a mobile device. 

Features 
Main features (initial release) 
		●  Uses Google Login for authentication  
		●  Users have access to full suite of lessons, categorized by levels  
		●  App keeps track of watched videos 
		●  Users can download videos for offline viewing*  
		●  New content push notifications*  
		●  Subscription fees can be paid using app*  
* Not implemented in current release , Planed for future releases

Key Considerations :

		 App allows users to login using their google account (in future Facebook login is supported)  
		­  App fetches data from servers using ‘google endpoints’ interface  
		­  App uses local Sqlite database to store user activity like videos watched, content stored  locally vs content not downloaded yet.  
		­ Since this is a music teaching app, user is expected to watch the video and learn. Video play stops when users move out to another activity  

Instructions to Run the APP :

Install the App on testing device using uploaded .ipa. from  github
Launch the app. provide your google login credentials
Once logged in, first screen is presented with various music lesson levels
select any level
next screen provides list of lessons available as a collection view
choose any cell to go to the song details page which provides description about the lesson
click play icon on the song image to play the lesson video

