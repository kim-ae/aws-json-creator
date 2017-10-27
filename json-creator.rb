require 'json/ext'

def open_output_file(file_number,output_prefix)
	File.open("#{output_prefix}#{file_number}.json","w")
end

def build_request_obj(quite)
	{"Objects"=>Array.new,"Quiet"=>quite}
end

def build_key_obj(content,folder)
	{"Key"=>folder+content}
end

def open_input_file(input_file)
	input=File.open(input_file, "r").read
	input.gsub!(/\r\n?/, "\n")
	return input
end

OBJECTS_PER_REQUEST = "objects-per-request"
FOLDER = "folder"
QUITE = "quite"
HELP = "help"
INPUT = "input-file"
OUTPUT = "output-file-prefix"

help = """
Parameters:
\t--folder=              default value \"\";
\t--quite=               default value 'true'
\t--objects-per-request= default value 1000
\t--input-file=          default value input.txt
\t--output-file-prefix=  default value output-
"""

args = Hash[ ARGV.join(' ').scan(/--?([^=\s]+)(?:=(\S+))?/) ]

if args.key?(HELP)
	puts help 
	exit
end
quite = if args.key?(QUITE) then args[QUITE] else true end
folder = if args.key?(FOLDER) then args[FOLDER] else "" end
objects_request = if args.key?(OBJECTS_PER_REQUEST) then args[OBJECTS_PER_REQUEST].to_i else 1000 end
output_prefix = if args.key?(OUTPUT) then args[OUTPUT] else "output-" end
input_file = if args.key?(INPUT) then args[INPUT] else "input.txt" end

file_index=1;
output = open_output_file(file_index,output_prefix)
input = open_input_file(input_file)
object_request_counter=0
request = build_request_obj(quite)
input.each_line do |line|
	object_request_counter+=1
	if object_request_counter > objects_request
		output.write(request.to_json)
		object_request_counter=1
		file_index+=1
		output = open_output_file(file_index,output_prefix)
		request = build_request_obj(quite)
	end
	request["Objects"].push(build_key_obj(line.delete("\n"),folder))
end
output.write(request.to_json)