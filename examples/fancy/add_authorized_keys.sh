echo $0 starts ...
if [ ! -d /root/.ssh ]; then
  mkdir /root/.ssh
  chmod 700 /root/.ssh
fi
echo ssh-rsa AFakeExampleKey1yc2EBIwAQEAq9m== >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
echo $0 done.
