# Motivation
Generate a json to be used in the s3api list options, in order to delete a list of objects from s3 using awscli. (http://docs.aws.amazon.com/cli/latest/reference/s3api/delete-objects.html).

# Usage
## Parameters
--folder=              default value ""; //the sub folders inside the bucket if there is  
--quiet=               default value 'true' //If the Quiet option will be true or false  
--objects-per-request= default value 1000 //Quantity per json file (aws accepts max of 1000 per request)  
--input-file=          default value input.txt //input file where each line is the nome of each object  
--output-file-prefix=  default value output- //prefix for each json file.  
## How to use
ruby create-json.rb --folder="level1/level2/" --quiet=true --objects-per-request=1000 --input-file=my_file.txt --output-file-prefix=output-
