# Terraform GKE + cloudsql + private ip

## ⚙️ Requirements

- terraform
- gcloud
- kubectl
- google oauth key

## 🚀 steps

1. create project on your gcp
2. gcloud auth login
3. make google oauth json file on project root (it must has editing project permission)
4. move project folder then terraform init and plan, apply (intput project id)
5. move infra folder then terraform init and plan, apply
6. remember sql root password in output prints

## 🎉 demo

connect cluster and run mysql-client container

```bash
$ gcloud beta container clusters get-credentials [cluster name] --region [region] --project [project id]
$ kubectl run -i --tty --rm mysql-client --image=mysql --restart=Never -- sh
```

connect mysql client

```bash
$ mysql -u root -p --host=[sql private ip]
password: [input root password]
```
