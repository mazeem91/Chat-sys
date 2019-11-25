# Application Chat System (Ruby)

- Application Chat System : my very first time writing ruby.

Based on:

* ```ruby '2.6.3'``` && ```rails '5.2.3'```

To deploy just:
RUN ```sudo sysctl -w vm.max_map_count=262144```
RUN ```docker-compose up -d```

Then use any Api request tool to ```http://localhost:3000/```:

- Application

  - get all ```get "applications/"``` 
  - create new ```post "applications/"``` 
  - get one ```get "applications/:token"``` 
  - update ```put "applications/:token/"``` 
  - delete ```delete "applications/:token/"``` 

- Chat

  - get all ```post "applications/:token/chats/"```
  - create new ```get "applications/:token/chats/"```

- Messages

  - get all ```post "applications/:token/chats/:number/messages"```
  - create new ```get "applications/:token/chats/:number/messages/"``` 
    * request takes body of one parameter ```{"body":"example"}```


* Notes : 
    There is crons schedauled:
    - Sync counts RUNS every 50 min , run it manauly throw:```docker-compose run web rails batch:sync_counts```.
