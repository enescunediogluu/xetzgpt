# XetzGPT Chat App
<br>
<img src='https://firebasestorage.googleapis.com/v0/b/hunted-village.appspot.com/o/Frame%20470.png?alt=media&token=dc5e2b79-a2ef-405c-8653-283ff328207c'>

I have built a simple chat app that uses Gemini LLM model that can be used for 
reaching information as fast as possible. I have learned too much while doing this project. 
I have used provider for state management and used Postman for api testing purposes. 
<br>

To test this app:
<br>
1) First clone the project.
```
git clone https://github.com/enescunediogluu/xetzgpt.git
```

2) On project folder, run this command to install packages
```
flutter pub get
```

3) You need to get your own API_KEY from [Gemini Api](https://ai.google.dev/)

4) Paste the api key in /lib/constants/api_consts.dart
```
const myApiKey = "YOUR_API_KEY_HERE";
const baseUrl =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=';
```
