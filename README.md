# blacklist-node-attrs cookbook

Prevents specified attributes from ohai (or whereever) being sent to the 
chef server during save. 

Counterpart to https://github.com/opscode/whitelist-node-attrs

# Usage

Add ````recipe[blacklist-node-attrs]```` to your run list, and set
attributes:

# Attributes

In this example the network.interfaces list is blacklisted.
This is useful if you have *lots* of IP address on your node, and you
don't want to upload them all to the chef server.

<pre>
node.set[:blacklist] = {
    "network" => {
        "interfaces" => true
    }
}
</pre>

