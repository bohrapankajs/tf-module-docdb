# Loads the schema
resource "null_resource" "mongodb-schema" { 
  
  # This ensures that schema will load only after the creation of DocumentDb
  depends_on = [aws_docdb_cluster.docdb, aws_docdb_cluster_instance.cluster_instances]

  provisioner "local-exec" {
command = <<EOF
  cd /tmp/
  curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
  wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
  unzip -o mongodb.zip 
  cd mongodb-main 
  mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile global-bundle.pem --username foo --password barbar8m < catalogue.js
  mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile global-bundle.pem --username foo --password barbar8m < users.js
EOF   
  }
}