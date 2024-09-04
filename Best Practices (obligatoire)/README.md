Des configurations que tu dois faire impérativement sauf si le sujet dis EXPLICITEMENT autre chose.
Pas obligé de tout appliquer dès le début : Soit rapide, vif, répond aux requêtes, Mais avant de quitter ton poste cela doit être appliqué : 
# EC2
* Au moins un Tag - Lui mettre un nom applique déjà le tag "Name" ! Suffisant si rien n'est demandé de plus!
* Dans l'ASG (Auto Scaling Group) il faut bien préciser ce Tag sinon les EC2 déployés par l'ASG n'auront pas de nom, donc pas de tag, donc pas de point sur cette partie!
* Créer tes propres AMI : USER DATA DOIT ETRE VIDE
  
# S3
* Activer le versionning! Ce n'est pas par défaut
* L'encryption doit rester activé afin de suivre les best pratices! Par défaut il est réglé sur SSE-S3 et est suffisant.

# VPC
* Activer VPC Flow Log - SUR CHAQUE VPC

# CloudWatch
* Alarme EC2 instance health status [Doc ici](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating_status_check_alarms.html)
Ou sinon : 
## Specific instance (attention si c'est dans un ASG...)
```bash
aws cloudwatch put-metric-alarm \
--alarm-name StatusCheckFailed-Alarm-for-i-1234567890abcdef0 \
--metric-name StatusCheckFailed \
--namespace AWS/EC2 \
--statistic Maximum \
--dimensions Name=InstanceId,Value=i-0e9737d94dfd3808e \
--unit Count \
--period 300 \
--evaluation-periods 2 \
--threshold 1 \
--comparison-operator GreaterThanOrEqualToThreshold
```
## Au sein d'un ALB
Modifie `<Your-AutoScalingGroupName>` Avec le nom de l'ALB.
Fais les deux check pour être sûr.
Avec ces paramètres de visible tu peux aisément le faire en GUI si besoin.
```bash
aws cloudwatch put-metric-alarm \
    --alarm-name "ASG-<Your-AutoScalingGroupName>-StatusCheckFailed_System" \
    --alarm-description "Alarm when system status check fails on any instance in the Auto Scaling group" \
    --metric-name StatusCheckFailed_System \
    --namespace AWS/EC2 \
    --statistic Maximum \
    --period 300 \
    --threshold 1 \
    --comparison-operator GreaterThanOrEqualToThreshold \
    --dimensions Name=AutoScalingGroupName,Value=<Your-AutoScalingGroupName> \
    --evaluation-periods 1
```
```bash
aws cloudwatch put-metric-alarm \
    --alarm-name "ASG-<Your-AutoScalingGroupName>-StatusCheckFailed_Instance" \
    --alarm-description "Alarm when system status check fails on any instance in the Auto Scaling group" \
    --metric-name StatusCheckFailed_Instance \
    --namespace AWS/EC2 \
    --statistic Maximum \
    --period 300 \
    --threshold 1 \
    --comparison-operator GreaterThanOrEqualToThreshold \
    --dimensions Name=AutoScalingGroupName,Value=<Your-AutoScalingGroupName> \
    --evaluation-periods 1
```

## Fais ton dashboard
En fin de journée, prends quelque metric, alarm etc, notamment ceux des ALB, et affiche les
Tu t'en fou de ce que tu mets, juste met des infos qui paraissent utile pour montrer que tu as fais un dashboard