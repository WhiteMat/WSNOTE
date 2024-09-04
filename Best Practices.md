Si rien n'est précisé dans le sujet, si rien ne contredit ces paramètres dans le sujet, alors il faut alors appliquer ces paramètres :
# S3
* Activer le versionning! Ce n'est pas par défaut
* L'encryption doit rester activé afin de suivre les best pratices! Par défaut il est réglé sur SSE-S3 et est suffisant.

# EC2
* Au moins un Tag - Lui mettre un nom applique déjà le tag "Name" ! Suffisant si rien n'est demandé de plus!
* Dans l'ASG (Auto Scaling Group) il faut bien préciser ce Tag sinon les EC2 déployés par l'ASG n'auront pas de nom, donc pas de tag, donc pas de point sur cette partie!




# Petit tips:
## EC2
* Configure la partie réseau (quel subnet etc...) ainsi que les tags dans l'ASG et pas dans le launch template
* Avant de configurer ASG assure toi d'avoir l'ALB de fait et au moins deux subnets. Tu pourras pas le creer sinon, tu perdras du temps.
