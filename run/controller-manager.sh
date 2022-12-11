#!/bin/bash
PATH=$PATH:${pwd}
kube-controller-manager \
--kubeconfig admin.conf \
--cluster-signing-cert-file=certs/ca.pem \
--cluster-signing-key-file=certs/ca-key.pem \
--service-account-private-key-file=certs/kubernetes-key.pem \
--use-service-account-credentials \
--root-ca-file=certs/ca.pem
