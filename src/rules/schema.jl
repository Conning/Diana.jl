struct getfield_types
	enter
	leave
	basic_types
	notbasic_types
	function getfield_types()
		scalars_types=["String", "Int", "Float", "Boolean"]
		basic_types=[[],[]]
		notbasic_types=[[],[]]
		function enter(node)
			if (node.kind == "FieldDefinition")
				local_type = node.tipe.name.value
				if(local_type in scalars_types)
				    push!(basic_types[1],node.name.value)
				    push!(basic_types[2],local_type)
				else
					push!(notbasic_types[1],node.name.value)
				    push!(notbasic_types[2],local_type)
				end
			end
			if (node.kind == "OperationTypeDefinition")
				push!(notbasic_types[1],node.operation)
				push!(notbasic_types[2],node.tipe.name.value)
			end
		end
		function leave(node)
		end
		new(enter,leave,basic_types,notbasic_types)
	end
end