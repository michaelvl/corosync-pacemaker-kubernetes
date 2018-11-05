.PHONY: build corosync-config corosync-run corosync-status corosync-authkey corosync-kube-secret corosync-daemonset

build:
	docker build -t coropace .

corosync-config:
	mkdir -p coro_cfg
	scripts/corosync.sh > coro_cfg/corosync.conf
	chown $$USER:$$USER coro_cfg/corosync.conf

corosync-run:
	docker run -d -v $$(pwd)/coro_cfg:/etc/corosync --net=host --privileged=true --name=coropace coropace

corosync-status:
	docker exec coropace corosync-cmapctl |grep members

cluster-status:
	docker exec coropace crm_mon -1

corosync-authkey:
	mkdir -p coro_cfg
	docker run -v $$(pwd)/coro_cfg:/etc/corosync coropace corosync-keygen -k /etc/corosync/authkey
	chown $$SUDO_USER:$$SUDO_USER coro_cfg/authkey

corosync-kube-secret:
	kubectl create secret generic etc-corosync --from-file=coro_cfg/corosync.conf --from-file=coro_cfg/authkey

corosync-daemonset:
	kubectl create -f daemonset.yml
