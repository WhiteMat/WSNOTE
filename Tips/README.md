## EC2
* Configure la partie réseau (quel subnet etc...), instance type, ainsi que les tags dans l'ASG et pas dans le launch template (plus pratique quand tu dois update)
* Avant de configurer ASG assure toi d'avoir l'ALB de fait et au moins deux subnets. ALB a besoin de 2 subnets
  
## Lambda 
### Layer
Le path d'un layer pour Python : `python/lib/python3.x/site-packages`.  
N'oublie pas de modifier la version de python dans la commande pip pour python-`version` et `target`.
Platforme de dispo : `manylinux2014_x86_64` (standard) et `manylinux2014_aarch64` (ARM)
`xx yy zz` sont tes paquets à installer.  
Target par défaut pour layer python 3.9
```bash
pip install \
    --platform manylinux2014_x86_64 \
    --target=./python/lib/python3.9/site-packages \
    --implementation cp \
    --python-version 3.x \
    --only-binary=:all: --upgrade \
    xx yy zz
```

## AWS CLI
Confirme ça avec du bash windows..Mais ca devrait être ok
```bash
# Avec quel permission tu es connecté
aws sts get-caller-identity

# Lister S3
aws s3 ls
# Copier un fichier local dans un bucket
aws cp <localefile> s3://<bucket>/

# Télécharger un fichier d'un bucket
aws cp s3://<bucket/xxx.jpg <localpath>

# Copier tout ton dossier actuel vers le bucket (optimisé, récursif, sync ne fait que la différence + suppression des anciens fichiers)
aws s3 sync ./ s3://<bucket/ --delete
# Télécharger tout le dossier s3 dans ton répertoire actuelle, récursif
aws s3 sync s3://<bucket/ ./ --delete
```