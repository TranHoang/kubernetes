# Collect all issues I met during learning k8s

## K8s and minikube setup

1. Cant start minikube inside a guest machine

```bash
minikube start
```

```Exception
E0402 08:55:40.697682    6921 start.go:159] Error starting host: Error creating host: Error executing step: Running precreate checks.
: This computer doesn't have VT-X/AMD-v enabled. Enabling it in the BIOS is mandatory.
```

Ref link
[https://www.virtualbox.org/ticket/4032](https://www.virtualbox.org/ticket/4032)
