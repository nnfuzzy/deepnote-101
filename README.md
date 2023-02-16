## Minimal toolset to work with deepnote
![localImage](deepnote_notebook.png)

1. Docker 
Sometimes you have problems with your dependencies, so just generate your own docker image and you're good to go.
   * docker build -t you/image_name:latest . # replace you & image_name with approriate values 
   * docker push you/image_name # Push it to dockerhub
2.Terraform 
Working with Notebooks demands sometimes external data and instead of uploading I like it to use the integrations inside deepnote (e.g. S3 and a database).
3. * cd terraform
   * terraform init
   * terraform apply
   * terraform output -raw db_password
3. Notebook
To have quick working example , you'll find attached a simple Notebook with some chat gpt api testing.
Ideally you start with your integrations.
