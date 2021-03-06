<img src="diana_logo.png" width="5%" border="0">      Diana.jl  
----------

[![Build Status](https://travis-ci.org/codeneomatrix/Diana.jl.svg?branch=master)](https://travis-ci.org/codeneomatrix/Diana.jl)
[![Diana](http://pkg.julialang.org/badges/Diana_0.6.svg)](http://pkg.julialang.org/detail/Diana)

This repository is an implementation of a GraphQL server, a query language for API created by Facebook.
See more complete documentation at http://graphql.org/

Looking for help? Find resources from the community.

### Getting Started

An overview of GraphQL in general is available in the [README](https://github.com/facebook/graphql/blob/master/README.md) for the Specification for GraphQL.

This package is intended to help you building GraphQL schemas/types fast and easily.
+ Easy to use: Diana.jl helps you use GraphQL in Julia without effort.
+ Data agnostic: Diana.jl supports any type of data source: SQL, NoSQL, etc. The intent is to provide a complete API and make your data available through GraphQL.
+ Make querys: Diana.jl allows queries to graphql schemas

Roadmap
-----
#### Version 0.0.2
 + graphql client 

#### Version 0.0.3
  + Creation of schemas / types

Installing
----------
```julia
Pkg.add("Diana")                                           #Release (Master branch)
Pkg.clone("git://github.com/codeneomatrix/Diana.jl.git")   #Development (Dev branch)
```

### Simple query

```julia
using Diana

query = """
{
  neomatrix{
    nombre
    linkedin
  }
} 
"""   

r = Query("https://neomatrix.herokuapp.com/graphql",query)
if (r.Info.status == 200) println(r.Data) end

```
```julia
using Diana

query = """
query(\$number_of_repos:Int!) {
  viewer {
    name
     repositories(last: \$number_of_repos) {
       nodes {
         name
       }
     }
   }
}
"""   

r = Query("https://api.github.com/graphql",query,vars= Dict("number_of_repos" => 3),auth="Bearer 7fe6d7e40cc191101b4708b078a5fcea35ee7280")
if (r.Info.status == 200) println(r.Data) end

```

### Query

```julia
using Diana

client = GraphQLClient("https://api.graph.cool/simple/v1/movies")
client.serverAuth("Bearer my-jwt-token")

or

client = GraphQLClient("https://api.graph.cool/simple/v1/movies","Bearer my-jwt-token")
```

```julia
query = """
{
  Movie(title: "Inception"){
    actors{
      name
    }
  }
}
""" 

r = client.Query(query)
if (r.Info.status == 200) println(r.Data) end
```
```julia
query = """
query getMovie(\$title: String!) {
  Movie(title:\$title) {
    releaseDate
    actors {
      name
    }
  }
}
"""  
r = client.Query(query,vars= Dict("title" => "Inception"))
if (r.Info.status == 200) println(r.Data) end
```
### Change server
```julia
client.serverUrl("https://api.graph.cool/simple/v1/movies")
```

## Contributing
Features are welcome !!

