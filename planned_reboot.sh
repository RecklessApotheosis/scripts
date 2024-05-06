export db_size=` du -sh /home/umbrel/umbrel/lnd/data/graph/mainnet/| awk {'print $1'}`
export time_up=`uptime | awk {'print $3'}`
export pauser="bos limit-forwarding --disable-forwards"

runner ()
{
	echo "Beginning reboot process for RecklessApotheosis Lightning Node, expected duration is 2 hours."
	date
	uptime
echo "pausing forwards now..."
$pauser &
bosPID=$$!
sleep 1m
echo "notifying peers..."
	time bos advertise --max-hops 0 --message "🥀 Downtime Alert: RecklessApotheosis is going down for a planned reboot! We are restarting the node for compaction (database is $db_size) and to apply config changes (it has been up for $time_up days!). Expected duration will be ~2 hours. In the meantime, if you haven't already, take a moment to classify our node! ⚡⚡⚡ https://www.amboss.space/c/reckless and if our channel doesn't come back up, reach out to us on Telegram @recklessapotheosis! #LiveReckless"

echo "re-enabling forwards."
#kill $bosPID
echo "rebooting..."
shutdown -r time 5m
}

runner | tee -a ~/output/planned_reboots.log  

