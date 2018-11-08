# Couchbase Deployment Scripts

# Summary

The two scripts can be used to provision a working highly available Couchbase Cluster with full SSL encryption between the nodes as well as an XDCR relationship with a secondary cluster.

**Warning:** These scripts are not completed, and therefore cannot be simply ran. Pay attention to the comments within for instruction on how to use them. 

# Instructions

1. Fill out both files with all variables set within angle brackets. 
2. Copy each block from `configure_static_networking.sh` to each respective node to configure networking.
3. Follow the steps in `build_cluster.sh` and copy paste each respective section on each respective node to provison a cluster. 

# Requirements:

1. PFX SSL certificate
2. Compute resources for 10 individual Linux servers. 
3. Working DNS

# TODO

1. Actually make this useful for someone
