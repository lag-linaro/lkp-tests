# nvdimm functions

configure_nvdimm()
{
	for ns in $(ls -d /sys/bus/nd/devices/namespace*); do
		bns=$(basename $ns)
		rmode=$(cat "$ns/mode")
		rsize=$(cat "$ns/size")
		[ "$rsize" -eq 0 ] && continue
		rmode=$(echo -n $rmode)
		mode=$(echo -n $mode)
		[ "$rmode" = "$mode" ] && continue
		/lkp/benchmarks/bin/ndctl create-namespace --reconfig=$bns \
						--force --mode="$mode" || exit 1
	done
}
