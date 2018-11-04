.PHONY: build config corosync-run corosync-status

build:
	docker build -t coropace .

config:
	mkdir -p coro_tmp
	scripts/corosync.sh > coro_tmp/corosync.conf

corosync-run:
	docker run -d -v $$(pwd)/coro_tmp:/etc/corosync --net=host --privileged=true --name=coropace coropace

corosync-status:
	docker exec coropace corosync-cmapctl |grep members

cluster-status:
	docker exec coropace crm_mon -1
