# README

- Application Chat System

Based on:

* ruby '2.6.3' && rails '5.2.3'

To deploy just:
RUN ```docker-compose up -d```

Then use any Api request tool to create:
- Application
```
  get all ```get "applications/"``` 
  create new ```post "applications/"``` 
  get one ```get "applications/:token"``` 
  update ```put "applications/:token/"``` 
  delete ```delete "applications/:token/"``` 
```
- Chat
```
  get all ```post "applications/:token/chats/"```
  create new ```get "applications/:token/chats/"```
```
- Messages
```
  get all ```post "applications/:token/chats/:number/messages"```
  create new ```get "applications/:token/chats/:number/messages/"```
```
