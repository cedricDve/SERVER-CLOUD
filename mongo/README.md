# MongoDB

````
db
````


````
use <db-name>
````


Insert
````
db.mensen.insert({"naam":"Joske"})
````

Insert Many 
````
db.movies.insertMany([
   {
      title: 'Titanic',
      year: 1997,
      genres: [ 'Drama', 'Romance' ],
      rated: 'PG-13',
      languages: [ 'English', 'French', 'German', 'Swedish', 'Italian', 'Russian' ],
      released: ISODate("1997-12-19T00:00:00.000Z"),
      awards: {
         wins: 127,
         nominations: 63,
         text: 'Won 11 Oscars. Another 116 wins & 63 nominations.'
      },
      cast: [ 'Leonardo DiCaprio', 'Kate Winslet', 'Billy Zane', 'Kathy Bates' ],
      directors: [ 'James Cameron' ]
   },
   {
      title: 'The Dark Knight',
      year: 2008,
      genres: [ 'Action', 'Crime', 'Drama' ],
      rated: 'PG-13',
      languages: [ 'English', 'Mandarin' ],
      released: ISODate("2008-07-18T00:00:00.000Z"),
      awards: {
         wins: 144,
         nominations: 106,
         text: 'Won 2 Oscars. Another 142 wins & 106 nominations.'
      },
      cast: [ 'Christian Bale', 'Heath Ledger', 'Aaron Eckhart', 'Michael Caine' ],
      directors: [ 'Christopher Nolan' ]
   },
   {
      title: 'Spirited Away',
      year: 2001,
      genres: [ 'Animation', 'Adventure', 'Family' ],
      rated: 'PG',
      languages: [ 'Japanese' ],
      released: ISODate("2003-03-28T00:00:00.000Z"),
      awards: {
         wins: 52,
         nominations: 22,
         text: 'Won 1 Oscar. Another 51 wins & 22 nominations.'
      },
      cast: [ 'Rumi Hiiragi', 'Miyu Irino', 'Mari Natsuki', 'Takashi Naitè' ],
      directors: [ 'Hayao Miyazaki' ]
   },
   {
      title: 'Casablanca',
      genres: [ 'Drama', 'Romance', 'War' ],
      rated: 'PG',
      cast: [ 'Humphrey Bogart', 'Ingrid Bergman', 'Paul Henreid', 'Claude Rains' ],
      languages: [ 'English', 'French', 'German', 'Italian' ],
      released: ISODate("1943-01-23T00:00:00.000Z"),
      directors: [ 'Michael Curtiz' ],
      awards: {
         wins: 9,
         nominations: 6,
         text: 'Won 3 Oscars. Another 6 wins & 6 nominations.'
      },
      lastupdated: '2015-09-04 00:22:54.600000000',
      year: 1942
   }
])
````

Find
````
db.moovies.find()
````

Find - Filter Data

````
db.movies.find( { "directors": "Christopher Nolan" } );
````

- Return movies that were released before the year 2000:
````
db.movies.find( { "released": { $lt: ISODate("2000-01-01") } } );
````
- Return movies that won more than 100 awards:
````
db.movies.find( { "awards.wins": { $gt: 100 } } );
````

- Return movies where the languages array contains either Japanese or Mandarin:
````
db.movies.find( { "languages": { $in: [ "Japanese", "Mandarin" ] } } )
````

- Return the id, title, directors, and year fields from all documents in the movies collection:
````
db.movies.find( { }, { "title": 1, "directors": 1, "year": 1 } );
````


---


```sql
# Start MongoDB
sudo systemctl start mongod

sudo systemctl status mongod

sudo systemctl stop mongod

sudo systemctl restart mongod

# Start using MongoDB
mongosh
```

```sql
# Kijk in welke database je zit te werken
db

# Geef alle databases
show dbs

# Switch to database OR create database
use test2

# Maak een document aan om ervoor te zorgen dat de database zichtbaar wordt in de lijst van alle databases
db.mensen.insert({"naam":"Joske"})
show dbs

# DELETE database
dropDatabase()

# Geef alle collecties weer
show collections

# Voor Collections geldt hetzelfde: wordt zichtbaar waar we data in de collections zetten
db.createCollection( <test>,
{
  size: 1048576,
  max:10000,
}

show collections # Geeft de collectie NIET weer

# DELETE collection
db.mensen.drop()

db.test.insert({"name":"zeub", "price":20})
db.test.find()
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bf016fb9-149c-4127-a212-fc018c3aaeee/Untitled.png)

