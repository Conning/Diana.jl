mutable struct Client
  Query::Function
  serverUrl::Function
  serverAuth::Function
end

mutable struct Result
	Info
	Data::String
end

function Query(url::String,data::String; vars::Dict=Dict(),auth::String="Bearer 0000", headers::Dict=Dict())
  r=post(url; json = Dict("query"=>data,"variables" => vars),headers = merge(Dict("Accept" => "application/json","Content-Type" => "application/json" ,"Authorization" => auth), headers))
  content = r.status == 200 ? String(r.data): "{\"data\":{}}"
  return Result(r,content)
end

function GraphQLClient(url::String, auth::String="Bearer 0000", headers::Dict=Dict())

my_url::String= url
my_auth::String= auth

	function serverUrl(url::String)
		my_url = url
	end

	function serverAuth(auth::String)
		my_auth= auth
	end

	function Query(data::String;vars::Dict=Dict())
	  r=post(my_url; json = Dict("query"=>data,"variables" => vars),headers = merge(Dict("Accept" => "application/json","Content-Type" => "application/json" ,"Authorization" => my_auth), headers))
	  content = r.status == 200 ? String(r.data): "{\"data\":{}}"
	  return Result(r,content)
	end

	return Client(Query,serverUrl,serverAuth)
end
