<div align='center'>

<img src=https://github.com/ATS527/ceal-placement-notifer/blob/main/logo/Placeme_final%403x.png alt="logo" width=97 height=97 />

<h1>Placeme By CEAL</h1>
<p>High Priority Placement Notifications</p>

<h4> <span> · </span> <a href="https://github.com/ATS527/ceal-placement-notifer/blob/master/README.md"> Documentation </a> <span> · </span> <a href="https://github.com/ATS527/ceal-placement-notifer/issues"> Report Bug </a> <span> · </span> <a href="https://github.com/ATS527/ceal-placement-notifer/issues"> Request Feature </a> </h4>


</div>

# :notebook_with_decorative_cover: Table of Contents

- [About the Project](#star2-about-the-project)
- [Roadmap](#compass-roadmap)
- [Contributing](#wave-contributing)
- [FAQ](#grey_question-faq)


## :star2: About the Project

### :camera: Screenshots
<div align="center"> <a href=""><img src="https://github.com/ATS527/ceal-placement-notifer/blob/main/screenshots/Screenshot_2024-02-24-13-26-34-64_6b576b88bcd45b63fbcb4f0a87aa9633.jpg" alt='image' width='800'/></a> </div>
<div align="center"> <a href=""><img src="https://github.com/ATS527/ceal-placement-notifer/blob/main/screenshots/Screenshot_2024-02-24-13-25-52-16_6b576b88bcd45b63fbcb4f0a87aa9633.jpg" alt='image' width='800'/></a> </div>
<div align="center"> <a href=""><img src="https://github.com/ATS527/ceal-placement-notifer/blob/main/screenshots/Screenshot_2024-02-24-13-25-58-62_6b576b88bcd45b63fbcb4f0a87aa9633.jpg" alt='image' width='800'/></a> </div>
<div align="center"> <a href=""><img src="https://github.com/ATS527/ceal-placement-notifer/blob/main/screenshots/Screenshot_2024-02-24-13-26-04-63_6b576b88bcd45b63fbcb4f0a87aa9633.jpg" alt='image' width='800'/></a> </div>
<div align="center"> <a href=""><img src="https://github.com/ATS527/ceal-placement-notifer/blob/main/screenshots/Screenshot_2024-02-24-13-26-12-35_6b576b88bcd45b63fbcb4f0a87aa9633(2).jpg" alt='image' width='800'/></a> </div>


<details> <summary>Server</summary> <ul>
<li><a href="">Node.js</a></li>
<li><a href="">Firebase</a></li>
</ul> </details>

### :dart: Features
- Send high priority push notifications
- Saving all the placement calls for future reference
- Ability to edit and add new placement calls

## :toolbox: Getting Started

### :bangbang: Prerequisites

- Install flutter and Node.js in your system
- Create an account in firebase and turn on authentication with google,firestorage, and firestore database


### :running: Run Locally

Clone the project

```bash
https://github.com/ATS527/ceal-placement-notifer
```
Install all the dependencies
```bash
flutter pub get
```
Create a .env file in project root directory

```bash
SERVER_URL="your-custom-server-url"
API_KEY="your-custom-api-key"
```
SERVER_URL is the url of server in which firebase-admin sdk is present,
API_KEY is to avoid unauthorised api calls


### :triangular_flag_on_post: Deployment

To get the optimised build run
```bash
flutter build appbundle
```


## :compass: Roadmap

* [ ] Create user profile
* [ ] User preferences for notifications


## :wave: Contributing

<a href="https://github.com/ATS527/ceal-placement-notifer/graphs/contributors"> <img src="https://contrib.rocks/image?repo=Louis3797/awesome-readme-template" /> </a>

Contributions are always welcome!

## :grey_question: FAQ

- Does the application works out of the box?
- No, you need to setup firebase first, then configure node.js server with firebase-admin sdk and run a notification server to really test the application.
