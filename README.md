# elven

![arquitetura](arch.png)

## Requisitos

- Conta na AWS
- Usuário com permissões
- Access Key CLI
- Terraform ou Opentofu
- AWS CLI

## Como usar

Clonar este projeto:
```
git clone https://github.com/julianorib/elven.git
```

Configurar credenciais AWS:
```
export AWS_ACCESS_KEY=<sua chave>
export AWS_SECRET_KEY=<sua senha>
```

Criar um Bucket para salvar o `Terraform State`
```
aws s3 mb s3://seubucket
aws s3 ls
```


Configurar variáveis `environment/prod/backend.tfvars` e `environment/prod/terraform.tfvars`


Iniciar o Terraform / Opentofu
```
cd elven
tofu init -backend-config=environment/prod/backend.tfvars
```

Criar uma Chave SSH:
```
ssh-keygen -t rsa
./id_rsa
```

Verificar se está tudo OK:
```
tofu validate
```

Fazer o Deploy:
```
tofu apply -var-file=environment/prod/terraform.tfvars
```

Ver outputs:
```
tofu output
tofu output -raw dbpassword
```

## Referências


https://aws.amazon.com/pt/tutorials/deploy-wordpress-with-amazon-rds/

https://aws.amazon.com/pt/getting-started/tutorials/create-network-file-system/

https://docs.pritunl.com/docs/installation

https://registry.terraform.io/providers/hashicorp/aws/latest/docs

https://aws.amazon.com/pt/elasticache/memcached/wordpress-with-memcached/

