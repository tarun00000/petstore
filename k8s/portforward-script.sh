#!/bin/sh

kubectl -n dev --address 0.0.0.0 port-forward service/service-petstore 8080 &
kubectl -n nginx-ingress --address 0.0.0.0 port-forward svc/ingress-controller-nginx-ingress 80 &
kubectl -n nginx-ingress --address 0.0.0.0 port-forward svc/ingress-controller-nginx-ingress 443


# Question
# Why use setsid instead of nohup for keeping a process running when the shell may time out or exit?

# Answer
# When you run a lengthy process such as nzreclaim interactively or in the background, it is attached to the shell. When the shell exits, the process will abort.

# Although you can use nohup to ensure that a command ignores the hangup signal, which occurs when a user disconnects from the pseudo-terminal (pty), it is not as reliable as setsid. 
# nohup is known to time out prematurely. Setsid runs commands in a separate session (that is not attached to your pty) so the commands run to completion even after you log out
# nohup, disown, & and setsid

#sudo setsid ./port-forward.sh