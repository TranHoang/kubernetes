#!/usr/bin/env bash
usage="$(basename "$0") Label a specific node

Options:
    -h  show this help text
    -n  name of the node that will be labeled
    -k  label key
    -v  label value

Examples:
    # Label minikube node by hardware=high-spec
    $(basename "$0") -n minikube -k hardware -v high-spec"

# Read container and image name
while getopts ":hn:k:v:" opt; do
  case $opt in
    h) echo "$usage"
        exit
        ;;
    n) node_name="$OPTARG"
        ;;
    k) key="$OPTARG"
        ;;
    v) value="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
        ;;
  esac
done
shift $((OPTIND-1))

if [[ $node_name ]] && [[ $key ]] && [[ $value ]]; then
    kubectl label nodes $node_name $key=$value
    kubectl get nodes $node_name --show-labels
else
    echo "Node name, Label keys, and Label values are not provided. Please run with -h options to display help."
fi
