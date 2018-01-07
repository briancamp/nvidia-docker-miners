# Enable hugepages, for Cryptonight
sysctl -w vm.nr_hugepages=128

# Kill any running nvidia-docker containers
nvidia-docker stop --time=2 $(nvidia-docker ps -q) > /dev/null 2>&1

