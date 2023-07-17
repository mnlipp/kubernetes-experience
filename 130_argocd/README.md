# Argo CD

## Install with helm

`helm repo add argo https://argoproj.github.io/argo-helm`
`kubectl create namespace argocd`
`helm install -n argocd my-argo argo/argo-cd -f 10_argocd-helm/values.yaml`

The values.yaml sets insecure access, because we want to use traefik
as front-end.

### Access UI (without ingress)

```
kubectl port-forward service/my-argo-argocd-server -n argocd 8080:80
```

Use URL: [http://localhost:8080](http://localhost:8080)

### Access UI (with ingress)

Apply `20_project.yaml` to get our "setup-project" started. You will
probably want to adjust the first source project to match your
private clone of this repository.

While Argo CD cannot manage Argo CD, we can at least put it's
"add-ons" under Argo CD's control.

Apply `30_argocd-app.yaml` to configure ingress for Argo CD. Adjust the
repository URL.

### Accces UI (common)

Get secret:

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Take over existing deployments

If you have not done it yet, apply `20_project.yaml` to get 
this "setup-project" started.

Now we can put all previously installed applications under
Argo CD's control by applying the files in `k8s-experience`.
Again, remember to adjust the repository URL where necessary.

Make sure to `helm uninstall` traefik and cert-manager before 
taking them over.


